require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  require 'json'

  # test "the truth" do
  #   assert true
  # end

  test 'returns results with a page count when given a query' do
    get '/games', params: {
      q: {
        title_matches: '%mario%'
      }
    }
    assert_response 200

    response_body = JSON.parse(response.body)
    results = response_body['results']
    current_page = response_body['current_page']
    total_pages = response_body['total_pages']
    total_count = response_body['total_count']

    assert_equal(results.size, 1)
    assert_equal(current_page, 1)
    assert_equal(total_pages, 1)
    assert_equal(total_count, 1)

    puts Game.first.to_json
    puts results[0]

    assert_equal(results[0]['title'], "Paper Mario")
  end
end
