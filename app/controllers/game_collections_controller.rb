class GameCollectionsController < ApplicationController
  before_action :set_game_collection, only: [:show, :update, :destroy]

  # GET /game_collections
  def index
    @game_collections = GameCollection.all

    render json: @game_collections
  end

  # GET /game_collections/1
  def show
    render json: @game_collection
  end

  # POST /game_collections
  def create
    @game_collection = GameCollection.new(game_collection_params)

    if @game_collection.save
      render json: @game_collection, status: :created, location: @game_collection
    else
      render json: @game_collection.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /game_collections/1
  def update
    if @game_collection.update(game_collection_params)
      render json: @game_collection
    else
      render json: @game_collection.errors, status: :unprocessable_entity
    end
  end

  # DELETE /game_collections/1
  def destroy
    @game_collection.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_collection
      @game_collection = GameCollection.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_collection_params
      params.require(:game_collection).permit(:owner_id, :game_id_id)
    end
end
