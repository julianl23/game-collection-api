# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_game, only: %i[show update destroy]

  # GET /games
  def index
    search = Game.ransack(params[:q])
    @games = search.result.includes(
      :multiplayer_modes,
      :platforms,
      :game_modes,
      :cover,
      :game_developers,
      :game_publishers,
    ).includes(game_developers: :company).page(params[:page])

    render json: {
      current_page: @games.current_page,
      total_pages: @games.total_pages,
      total_count: @games.count,
      results: @games
    }
  end

  # GET /games/1
  def show
    render json: @game, include: %i[
      multiplayer_modes
      platforms
      game_modes
      game_developers
      game_publishers
      cover
    ]
  end

  # POST /games
  def create
    @game = Game.new(game_params)

    if @game.save
      render json: @game, status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.includes(
      :multiplayer_modes,
      :platforms,
      :game_modes,
      :cover,
      :game_developers,
      :game_publishers
    ).includes(game_developers: :company).find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def game_params
    params.require(:game).permit(
      :title,
      :description,
      :igdb_id,
      :url,
      :release_date
    )
  end
end
