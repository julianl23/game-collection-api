require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get a single user" do
    get user_url(User.first)
    assert_response :success
    assert_equal(response.body, User.first.to_json)
  end
end
