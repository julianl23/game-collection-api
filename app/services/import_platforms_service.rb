class ImportPlatformsService
  def self.add_platforms_for_page(page)
    page.each do |item|
      id = item['id']
      name = item['name']

      raise ArgumentError, 'Missing ID for platform' unless id

      puts "Creating platform: #{id}:#{name}"
      Platform.create(name: name, igdb_id: id)
    end
  end
end
