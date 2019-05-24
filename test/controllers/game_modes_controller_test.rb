require 'test_helper'

class GameModesControllerTest < ActionDispatch::IntegrationTest
  setup { @game_mode = game_modes(:one) }

  test 'should get index' do
    get game_modes_url, as: :json
    assert_response :success
  end

  test 'should create game_mode' do
    assert_difference('GameMode.count') do
      post game_modes_url,
           params: {
             game_mode: { igdb_id: @game_mode.igdb_id, name: @game_mode.name }
           },
           as: :json
    end

    assert_response 201
  end

  test 'should show game_mode' do
    get game_mode_url(@game_mode), as: :json
    assert_response :success
  end

  test 'should update game_mode' do
    patch game_mode_url(@game_mode),
          params: {
            game_mode: { igdb_id: @game_mode.igdb_id, name: @game_mode.name }
          },
          as: :json
    assert_response 200
  end

  test 'should destroy game_mode' do
    assert_difference('GameMode.count', -1) do
      delete game_mode_url(@game_mode), as: :json
    end

    assert_response 204
  end
end
