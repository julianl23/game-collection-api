# frozen_string_literal: true

class GameModesController < ApplicationController
  before_action :set_game_mode, only: %i[show update destroy]

  # GET /game_modes
  def index
    @game_modes = GameMode.all

    render json: @game_modes
  end

  # GET /game_modes/1
  def show
    render json: @game_mode
  end

  # POST /game_modes
  def create
    @game_mode = GameMode.new(game_mode_params)

    if @game_mode.save
      render json: @game_mode, status: :created, location: @game_mode
    else
      render json: @game_mode.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /game_modes/1
  def update
    if @game_mode.update(game_mode_params)
      render json: @game_mode
    else
      render json: @game_mode.errors, status: :unprocessable_entity
    end
  end

  # DELETE /game_modes/1
  def destroy
    @game_mode.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game_mode
    @game_mode = GameMode.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def game_mode_params
    params.require(:game_mode).permit(:igdb_id, :name)
  end
end
