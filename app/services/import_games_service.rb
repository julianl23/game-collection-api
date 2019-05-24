#
# Expander Problem
# I only get 50k a month with the Pro plan
# It costs an extra request per expanded resource
#
# Expands so far:
# Cover
# Involved companies
# Multiplayer modes
#
# 102250 games / 100 items per page = 1023 pages
# 1023 pages * 4 requests = 4092 total requests

class ImportGamesService
  def self.add_games_for_page(page, platform)
    page.each do |item|
      igdb_id = item['id']
      title = item['name']

      puts "Processing igdb ##{igdb_id} - #{title}"

      description = item['summary']
      if item['first_release_date']
        timestamp_string = item['first_release_date'].to_s
      end
      release_date = nil

      if timestamp_string
        release_date = DateTime.strptime(timestamp_string, '%s')
      end

      url = item['url']

      existing_game = Game.find_by_igdb_id(igdb_id)

      if existing_game
        # For some ungodly reason, duplicates come back in the result set from IGDB
        # We need to handle this situation and not re-add the same platform repeatedly.
        existing_game_platform =
          GamePlatform.where(
            [
              'platform_id = :p AND game_id = :g',
              { p: platform.id, g: existing_game.id }
            ]
          )
            .first
        existing_game.platforms << platform unless existing_game_platform
      end

      next unless existing_game.nil?

      involved_companies =
        self.handle_involved_companies(item['involved_companies'])

      new_game =
        Game.create(
          title: title,
          description: description,
          release_date: release_date,
          igdb_id: igdb_id,
          url: url
        )

      new_game.platforms << platform

      involved_companies[:publishers].each do |item|
        new_game.game_publishers.create(company_id: item.id)
      end

      involved_companies[:developers].each do |item|
        new_game.game_developers.create(company_id: item.id)
      end

      cover_ref = item['cover']

      if cover_ref
        if cover_ref.is_a?(Integer) || cover_ref.is_a?(String)
          puts "Cover for igdb ID #{igdb_id} is not a hash"
        else
          existing_cover = Cover.find_by_igdb_id(cover_ref['id'])
          if existing_cover
            new_game.cover = existing_cover
          else
            new_cover =
              Cover.create(
                game: new_game,
                igdb_id: cover_ref['id'],
                height: cover_ref['height'],
                width: cover_ref['width'],
                igdb_image_id: cover_ref['image_id'],
                url: cover_ref['url']
              )

            new_game.cover = new_cover
          end
        end
      end

      new_game.save!

      if item['game_modes']
        local_game_modes = []
        GameMode.where(igdb_id: item['game_modes']).each do |mode|
          local_game_modes << GameModeItem.new(game: new_game, game_mode: mode)
        end

        new_game.game_mode_items << local_game_modes
      end

      # Multiplayer modes seem really sparse in the IGDB data
      item['multiplayer_modes']&.each do |mode|
        self.add_multiplayer_mode(mode, new_game)
      end
    end
  end

  def self.handle_involved_companies(involved_companies)
    local_developers = []
    local_publishers = []

    unless involved_companies.nil?
      companies_to_retrieve = []

      involved_companies.each do |involved_company|
        if involved_company.is_a?(Integer) || involved_company.is_a?(String)
          # Sometimes, the involved company comes back as an integer, not a
          # hash. I think maybe I could collect them and try to pull them all
          # by ID at the end, but I don't know that it matters too much

          puts "Involved company is not a hash (got #{involved_company})"
          next
        end

        involved_company_id = involved_company['company']
        next unless involved_company_id

        local_company = Company.find_by_igdb_id(involved_company_id)

        if local_company
          if involved_company['developer'] == true
            local_developers << local_company
          elsif involved_company['publisher'] == true
            local_publishers << local_company
          end
        else
          companies_to_retrieve << involved_company['company']
        end
      end

      unless companies_to_retrieve.empty?
        fields = %w[id name description slug].join(',')

        request = IGDBRequestService.new(endpoint: 'companies')
        response =
          request.get(
            fields: fields, filter: "id = (#{companies_to_retrieve.join(',')})"
          )
        JSON.parse(response.body).each do |item|
          involved_company =
            involved_companies.find { |comp| comp['company'] == item['id'] }
          new_company = self.add_related_company(item)

          if involved_company['developer'] == true
            local_developers << new_company
          elsif involved_company['publisher'] == true
            local_publishers << new_company
          end
        end
      end
    end

    { developers: local_developers, publishers: local_publishers }
  end

  def self.add_related_company(company_json)
    Company.create(
      igdb_id: company_json['id'],
      name: company_json['name'],
      description: company_json['description'],
      slug: company_json['slug']
    )
  end

  def self.add_multiplayer_mode(mode, game_obj)
    if mode.is_a?(Integer) || mode.is_a?(String)
      puts "Multiplayer mode is not a hash - #{mode}"
      return nil
    end

    if mode['platform']
      mode_platform = Platform.find_by_igdb_id(mode['platform'])

      MultiplayerMode.create!(
        game: game_obj,
        platform: mode_platform,
        campaign_coop: mode['campaigncoop'],
        drop_in: mode['dropin'],
        lan_coop: mode['lancoop'],
        offline_coop: mode['offlinecoop'],
        offline_coop_max: mode['offlinecoopmax'],
        offline_max: mode['offlinemax'],
        online_coop: mode['onlinecoop'],
        online_coop_max: mode['onlinecoopmax'],
        online_max: mode['onlinemax'],
        splitscreen: mode['splitscreen'],
        splitscreen_online: mode['splitscreenonline']
      )
    end
  end
end
