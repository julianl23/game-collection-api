# frozen_string_literal: true

class GameCollectionsController < ApplicationController
  before_action :set_game_collection, only: %i[index show update destroy]
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.json
    end
  end

  def show
    render json: @game_collection
  end

  # PATCH/PUT /game_collections/1
  def update
    # if @game_collection.update(game_params)
    #   render json: @game_collection
    # else
    #   render json: @game_collection.errors, status: :unprocessable_entity
    # end
    #
    #
    #
    #
    # use this to add a game?
    # is there any metadata on the collection that i'd want to change?
    # should adding a game be PATCH /game_collections/games?
  end

  # DELETE GET /game_collections/1
  def destroy
    @game_collection.destroy
  end

  #
  # private
  #
  # # Use callbacks to share common setup or constraints between actions.
  def set_game_collection
    collection_items_includes = [
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
    ]

    @game_collection = if params.key?(:id)
                         GameCollection.includes(game_collection_items: collection_items_includes).find(params[:id])
                       else
                         GameCollection.includes(game_collection_items: collection_items_includes).find_by_user_id(current_user)
                       end
  end

  # # Only allow a trusted parameter "white list" through.
  # def game_params
  #   params.require(:game).permit(:title, :description, :igdb_id, :url, :release_date)
  # end
end
