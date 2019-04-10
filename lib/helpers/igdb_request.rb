class IGDBRequest
  attr_accessor :offset, :limit, :endpoint

  def initialize(params = {})
    @url = 'https://api-v3.igdb.com'
    @endpoint = params.fetch(:endpoint, '')
    @offset = params.fetch(:offset, nil)
    @limit = params.fetch(:limit, 50)
  end

  def get(params = {})
    # params
    #   fields
    #   filter
    #   sort

    fields = params.fetch(:fields, nil)
    filter = params.fetch(:filter, nil)
    sort = params.fetch(:sort, nil)

    api_url = "#{@url}/#{endpoint}"
    body = ''
    body << "where #{filter}; " unless filter.nil?
    body << "fields: #{fields}; " unless fields.nil?
    body << "sort: #{sort}; " unless sort.nil?
    body << "offset #{@offset}; " unless offset.nil?
    body << "limit #{@limit}; "

    headers = { 'user-key': ENV['IGDB_KEY'], accept: 'application/json' }

    HTTParty.get(api_url,
                 headers: headers,
                 body: body || '')
  end
end
