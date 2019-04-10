# frozen_string_literal: true

namespace :igdb do
  require 'dotenv/tasks'
  require 'json'
  require_relative '../helpers/igdb_request'
  require_relative '../helpers/import_platform_helper'
  require_relative '../helpers/import_games_helper'

  # Run in this order:
  # 1. get_platforms
  # 2. get_game_modes
  # 3. get_games
  # 4. index_games

  desc 'Pulls down platform list from the IGDB API and creates Platform objects in db'
  task get_platforms: :environment do
    page_size = 50
    fields = 'abbreviation,alternative_name,category,created_at,generation,name,platform_logo,product_family,slug,summary,updated_at,url,versions,websites'
    request = IGDBRequest.new(endpoint: 'platforms')

    puts 'Getting page 1'
    first_response = request.get(fields: fields)
    count = first_response.headers['x-count'].to_i

    puts "Found #{count} platforms"



    # HEY
    #
    # Here's where we're at
    #
    # Running stuff in lib/helpers isnt working, cant get active record
    # So, lets do two things
    # 1. Change the folder structure to match the one in here https://edelpero.svbtle.com/everything-you-always-wanted-to-know-about-writing-good-rake-tasks-but-were-afraid-to-ask
    #    That way we don't have one big, awful igdb.rake
    # 2. Move the stuff in lib/helpers to app/services like in that articl
    #    That'll give me access to active record and be usable in the current environment








    ImportPlatformHelper.add_platforms_for_page(JSON.parse(first_response.body))

    if count > 50 # TODO: Don't hardcode that value?
      pages = (count.to_f / page_size.to_f).ceil

      (1...pages).each do |i|
        puts "Getting page #{i + 1}"
        request.offset = page_size * i
        response = request.get(fields: fields)

        ImportPlatformHelper.add_platforms_for_page(JSON.parse(response.body))
      end
    end
  end

  desc 'Pulls down the list of game modes from the IGDB api and creates GameMode objects in DB'
  task get_game_modes: :environment do
    request = IGDBRequest.new(endpoint: 'game_modes')
    puts 'Getting game modes'
    response = request.get(fields: 'created_at,name,slug,updated_at,url')

    JSON.parse(response.body).each do |item|
      id = item['id']
      name = item['name']
      puts "Adding game mode #{id}:#{name}"
      GameMode.create(igdb_id: id, name: name)
    end
  end

  desc 'Pulls down games for each platform from the IGDB api and creates Game objects in DB'
  task get_games: :environment do
    platform_list = [24, 33, 46, 9, 11, 37, 48, 8, 38, 23, 5, 49, 19, 32, 12, 22, 35, 4, 18, 7, 41, 64, 20, 21]
    page_size = 100

    # For each platform id
    # Pull down the games for that platform and create a Game object for them

    # platform_list.each do |platform_id|
    #   puts "Getting games for platform ID #{platform_id}"
    # platform = Platform.find(platform)



    ## test code, hardcoded
    platform_id = 24
    current_platform = Platform.find_by_igdb_id(platform_id)
    ## end test code, hardcoded

    fields = %w[
      id
      name
      summary
      first_release_date
      cover.*
      platforms
      game_modes
      multiplayer_modes
      involved_companies.*
    ].join(',')

    request = IGDBRequest.new(endpoint: 'games')
    response = request.get(fields: fields,
                           filter: "release_dates.platform = #{platform_id}")
    ImportGamesHelper.add_games_for_page(JSON.parse(response.body), current_platform)

    puts response.body

    count = response.headers['x-count'].to_i

    puts count

    # next unless count > 50 # TODO: Don't hardcode that value?
    #
    # pages = (count.to_f / page_size.to_f).ceil
    #
    # (1...pages).each do |i|
    #   puts "Getting page #{i + 1}"
    #   request.offset = page_size * i
    #   response = request.get(fields: fields)
    #
    #   ImportGamesHelper.add_games_for_page(JSON.parse(response.body), platform)
    # end
    # end
  end

  desc 'TODO'
  task index_games: :environment do
  end
end
