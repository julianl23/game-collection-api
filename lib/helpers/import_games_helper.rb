# frozen_string_literal: true

require_relative './igdb_request'

# fields:
#  has_one :cover
#   has_many :publisher
#   has_many :developer
#   has_many :game_modes
#   has_many :platforms
#   has_many :multiplayer_modes
#
# COVER PROBLEM
# I only get 50k a month with the Pro plan
# It costs one extra request to get a full cover
# That means each page costs two requests
#
# 102250 games/50 pages = 2045 requests * 2 = 4090 requests
# Pro plan lets me go up to 100pp
# 102250 / 100 = 1023 = 2046
#
#
# Expands so far:
# Cover
# Involved companies

class ImportGamesHelper
  def self.add_games_for_page(page, platform)
    page.each do |item|
      igdb_id = item['id']
      title = item['title']
      description = item['description']
      release_date = Date.parse(item['release_date'])

      existing_game = Game.find_by_igdb_id(igdb_id)
      next unless existing_game.nil?

      #### Handle creating companies not already in the db, and adding them to a map
      #### of involved companies to be added later
      involved_companies = handle_involved_companies(item['involved_companies'])


      cover_ref = item['cover']

      # API response example
      # "cover": {
      #     "id": 4125,
      #     "game": 3900,
      #     "height": 353,
      #     "image_id": "ihielb7udbo4ha5qyexz",
      #     "url": "//images.igdb.com/igdb/image/upload/t_thumb/ihielb7udbo4ha5qyexz.jpg",
      #     "width": 256
      # },

      # Need to update schema for cover to match the new response format

      # t.string :url
      # t.string :cloudinary_id
      # t.integer :width
      # t.integer :height
      # t.references :game

      # WAIT
      # For platform, one game can have many platforms
      # How do we represent that as we created that?

      new_game = Game.create(title: title,
                             description: description,
                             release_date: release_date,
                             platform: platform,
                             igdb_id: igdb_id)

      new_game.publishers << involved_companies['publishers']
      new_game.developers << involved_companies['developers']

      # title
      # description
      # release_date
      # igdb_id = item['id']
      # game mode (assoc)
      # olatform (assoc)
      # multiplayer mode (assoc)
      # cover (assoc)
    end
  end

  def handle_involved_companies(involved_companies)
    local_developers = []
    local_publishers = []

    unless involved_companies.nil?
      companies_to_retrieve = []

      involved_companies.each do |involved_company|
        local_company = Company.find_by_igdb_id(involved_company['company'])
        if local_company.exists?
          if involved_company['developer'] == true
            local_developers << local_company
          elsif involved_company['publisher'] == true
            local_publishers << local_company
          end
        else
          companies_to_retrieve >> involved_company['id']
        end
      end

      unless companies_to_retrieve.empty?
        # ok, now pull down the companies and run that same logic as above to
        # sort them into developer/publisher

        fields = %w[
            id
            name
            description
            slug
          ].join(',')

        request = IGDBRequest.new(endpoint: 'companies')
        response = request.get(fields: fields,
                               filter: "id = [#{companies_to_retrieve.join(',')}]")
        JSON.parse(response.body).each do |item|
          new_company = add_related_company(item)
          if item['developer'] == true
            local_developers << new_company
          elsif item['publisher'] == true
            local_developers << new_company
          end
        end
      end
    end

    { developers: local_developers, publishers: local_publishers }
  end

  def add_related_company(company_json)
    puts "Creating company igdb ##{company_json['id']}: #{company_json['name']}"
    Company.create(igdb_id: company_json['id'],
                   name: company_json['name'],
                   description: company_json['description'],
                   slug: company_json['slug'])
  end
end
