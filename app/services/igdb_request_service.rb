class IGDBRequestService
  attr_accessor :offset, :limit, :endpoint

  def initialize(params = {})
    @url = 'https://api-v3.igdb.com'
    @endpoint = params.fetch(:endpoint, '')
    @offset = params.fetch(:offset, nil)
    @limit = params.fetch(:limit, nil)
  end

  def get(params = {})
    # params
    #   fields
    #   filter
    #   sort

    fields = params.fetch(:fields, nil)
    filter = params.fetch(:filter, nil)
    sort = params.fetch(:sort, nil)
    debug = params.fetch(:debug, nil)

    api_url = "#{@url}/#{endpoint}"
    body = ''
    body << "where #{filter}; " unless filter.nil?
    body << "fields: #{fields}; " unless fields.nil?
    body << "sort: #{sort}; " unless sort.nil?
    body << "offset #{@offset}; " unless @offset.nil?
    body << "limit #{@limit}; " unless @limit.nil?

    headers = { 'user-key': ENV['IGDB_KEY'], accept: 'application/json', 'content-type': 'application/json' }

    if debug
      puts "API URL: #{api_url}"
      puts "BODY: #{body}"
    end

    HTTP.headers(headers).get(api_url, body: body)
  end
end
