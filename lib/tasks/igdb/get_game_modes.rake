namespace :igdb do
  desc 'Pulls down the list of game modes from the IGDB api and creates GameMode objects in DB'
  task get_game_modes: :environment do
    request = IGDBRequestService.new(endpoint: 'game_modes')
    puts 'Getting game modes'
    response = request.get(fields: 'created_at,name,slug,updated_at,url')

    JSON.parse(response.body).each do |item|
      id = item['id']
      name = item['name']
      puts "Adding game mode #{id}:#{name}"
      GameMode.create(igdb_id: id, name: name)
    end
  end
end
