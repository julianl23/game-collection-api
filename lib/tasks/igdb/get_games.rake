namespace :igdb do
  desc 'Pulls down games for each platform from the IGDB api and creates Game objects in DB'
  task get_games: :environment do
    platform_list = [24, 33, 46, 9, 11, 37, 48, 8, 38, 23, 5, 49, 19, 32, 12, 22, 35, 4, 18, 7, 41, 64, 20, 21, 104]
    page_size = 100

    # For each platform id
    # Pull down the games for that platform and create a Game object for them

    platform_list.each do |platform_id|
      puts "Getting games for platform ID #{platform_id}"
      puts 'Getting page 1'

      current_platform = Platform.find_by_igdb_id(platform_id)

      fields = %w[
        id
        name
        summary
        first_release_date
        cover.*
        platforms
        game_modes
        multiplayer_modes.*
        involved_companies.*
        url
      ].join(',')

      request = IGDBRequestService.new(endpoint: 'games')
      # Need to have category = 0 filter in there to catch any DLC. It also prevents
      # the size of the list from being greater than the offset limit of 5000
      response = request.get(fields: fields,
                             filter: "release_dates.platform = #{platform_id} & category = 0")
      ImportGamesService.add_games_for_page(JSON.parse(response.body), current_platform)

      count = response.headers['x-count'].to_i

      next unless count > page_size

      # First page gets 10 results
      # Then we calculate how many pages total we'll get
      # We use the offset system to get the next pages.
      # Page 2 will be limit: 100, offset: 10
      # Page 3 will be limit: 100, offset: 110,
      # Page 4 will be limit: 100, offset: 210

      pages = (count.to_f / page_size.to_f).ceil

      puts "Heres the page number count #{pages}"

      request.limit = page_size

      (1...pages).each do |i|
        puts "Getting page #{i + 1}"
        request.offset = (page_size * i) + 10
        response = request.get(fields: fields)

        ImportGamesService.add_games_for_page(JSON.parse(response.body), current_platform)
      end
    end
  end

end
