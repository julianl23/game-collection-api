# frozen_string_literal: true

class MultiplayerModesController < ApplicationController
  before_action :set_multiplayer_mode, only: %i[show update destroy]

  # GET /multiplayer_modes
  def index
    @multiplayer_modes = MultiplayerMode.all

    render json: @multiplayer_modes
  end

  # GET /multiplayer_modes/1
  def show
    render json: @multiplayer_mode
  end

  # POST /multiplayer_modes
  def create
    @multiplayer_mode = MultiplayerMode.new(multiplayer_mode_params)

    if @multiplayer_mode.save
      render json: @multiplayer_mode, status: :created, location: @multiplayer_mode
    else
      render json: @multiplayer_mode.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /multiplayer_modes/1
  def update
    if @multiplayer_mode.update(multiplayer_mode_params)
      render json: @multiplayer_mode
    else
      render json: @multiplayer_mode.errors, status: :unprocessable_entity
    end
  end

  # DELETE /multiplayer_modes/1
  def destroy
    @multiplayer_mode.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_multiplayer_mode
    @multiplayer_mode = MultiplayerMode.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def multiplayer_mode_params
    params.fetch(:multiplayer_mode, {})
  end
end
