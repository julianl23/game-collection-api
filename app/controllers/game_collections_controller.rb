# frozen_string_literal: true

class GameCollectionsController < ApplicationController
  before_action :set_game_collection, only: %i[show update destroy]
  before_action :authenticate_user!

  # # GET /games
  # def index
  #   @games = Game.all
  #
  #   render json: @games
  # end
  #
  # GET /game_collections/1
  def show
    render json: @game_collection
  end
  #
  # # POST /games
  # def create
  #   @game = Game.new(game_params)
  #
  #   if @game.save
  #     render json: @game, status: :created, location: @game
  #   else
  #     render json: @game.errors, status: :unprocessable_entity
  #   end
  # end

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
    @game_collection = GameCollection.find(params[:id])
  end

  # # Only allow a trusted parameter "white list" through.
  # def game_params
  #   params.require(:game).permit(:title, :description, :igdb_id, :url, :release_date)
  # end
end
