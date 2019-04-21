namespace :igdb do
  desc 'Pulls down platform list from the IGDB API and creates Platform objects in db'
  task get_platforms: :environment do
    page_size = 50
    fields = 'abbreviation,alternative_name,category,created_at,generation,name,platform_logo,product_family,slug,summary,updated_at,url,versions,websites'
    request = IGDBRequestService.new(endpoint: 'platforms')

    puts 'Getting page 1'
    first_response = request.get(fields: fields)
    count = first_response.headers['x-count'].to_i

    puts "Found #{count} platforms"

    ImportPlatformsService.add_platforms_for_page(JSON.parse(first_response.body))

    if count > 50 # TODO: Don't hardcode that value?
      pages = (count.to_f / page_size.to_f).ceil

      (1...pages).each do |i|
        puts "Getting page #{i + 1}"
        request.offset = page_size * i
        response = request.get(fields: fields)

        ImportPlatformsService.add_platforms_for_page(JSON.parse(response.body))
      end
    end
  end

end
