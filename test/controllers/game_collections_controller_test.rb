require 'test_helper'

class GameCollectionsControllerTest < ActionDispatch::IntegrationTest
  setup { @game_collection = game_collections(:one) }

  # test 'should get index' do
  #   get game_collections_url, as: :json
  #   assert_response :success
  # end
  #
  # test 'should create game_collection' do
  #   assert_difference('GameCollection.count') do
  #     post game_collections_url,
  #          params: {
  #            game_collection: {
  #              game_id_id: @game_collection.game_id_id,
  #              owner_id: @game_collection.owner_id
  #            }
  #          },
  #          as: :json
  #   end
  #
  #   assert_response 201
  # end
  #
  # test 'should show game_collection' do
  #   get game_collection_url(@game_collection), as: :json
  #   assert_response :success
  # end
  #
  # test 'should update game_collection' do
  #   patch game_collection_url(@game_collection),
  #         params: {
  #           game_collection: {
  #             game_id_id: @game_collection.game_id_id,
  #             owner_id: @game_collection.owner_id
  #           }
  #         },
  #         as: :json
  #   assert_response 200
  # end
  #
  # test 'should destroy game_collection' do
  #   assert_difference('GameCollection.count', -1) do
  #     delete game_collection_url(@game_collection), as: :json
  #   end
  #
  #   assert_response 204
  # end
end
