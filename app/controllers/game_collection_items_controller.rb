class GameCollectionItemsController < ApplicationController
  before_action :set_game_collection, only: %i[index create show update destroy]
  before_action :authenticate_user!

  # POST /game_collections/:game_collection_id/items
  def create
    @game_collection_item = GameCollectionItem.new(
      game_collection_item_params.merge(game_collection: @game_collection)
    )

    if @game_collection_item.save
      render json: @game_collection_item, status: :created, location: @game_collection_item
    else
      render json: @game_collection_item.errors, status: :unprocessable_entity
    end
  end

  # GET /game_collections/:game_collection_id/items
  def index
    # TODO: This should be paginated

    render json: @game_collection.game_collection_items, include: {
      game: {
        platforms: {},
        game_developers: {
          include: %i[company]
        },
        game_publishers: {
          include: %i[company]
        },
        cover: {}
      },
      platform: {}
    }
  end

  #
  # private
  #
  # # Use callbacks to share common setup or constraints between actions.
  def set_game_collection
    @game_collection = GameCollection.includes(game_collection_items: [
                                                 {
                                                   game: [
                                                     :multiplayer_modes,
                                                     :platforms,
                                                     :game_modes,
                                                     :cover,
                                                     {
                                                       game_developers: [
                                                         :company
                                                       ]
                                                     },
                                                     :game_publishers
                                                   ]
                                                 }
                                               ]).find(params[:game_collection_id])
  end

  # # Only allow a trusted parameter "white list" through.
  def game_collection_item_params
    params.require(:game_collection_item).permit(
      :game_id,
      :platform_id,
      :is_borrowed,
      :cost,
      :note_text,
      :is_private_note,
      :has_cart_disk_item,
      :has_case_box,
      :has_manual,
      :has_other_items
    )
  end
end