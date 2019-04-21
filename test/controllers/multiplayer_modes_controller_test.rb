

require 'test_helper'

class MultiplayerModesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multiplayer_mode = multiplayer_modes(:one)
  end

  test 'should get index' do
    get multiplayer_modes_url, as: :json
    assert_response :success
  end

  test 'should create multiplayer_mode' do
    assert_difference('MultiplayerMode.count') do
      post multiplayer_modes_url, params: { multiplayer_mode: {} }, as: :json
    end

    assert_response 201
  end

  test 'should show multiplayer_mode' do
    get multiplayer_mode_url(@multiplayer_mode), as: :json
    assert_response :success
  end

  test 'should update multiplayer_mode' do
    patch multiplayer_mode_url(@multiplayer_mode), params: { multiplayer_mode: {} }, as: :json
    assert_response 200
  end

  test 'should destroy multiplayer_mode' do
    assert_difference('MultiplayerMode.count', -1) do
      delete multiplayer_mode_url(@multiplayer_mode), as: :json
    end

    assert_response 204
  end
end
