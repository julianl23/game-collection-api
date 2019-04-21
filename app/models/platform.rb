# frozen_string_literal: true

class Platform < ApplicationRecord
  has_many :game_platforms
  has_many :games, through: :game_platforms

  has_many :multiplayer_modes
end
