# frozen_string_literal: true

class Game < ApplicationRecord
  has_one :cover
  has_many :companies, through: :developers
  has_many :companies, through: :publishers

  has_many :game_mode_items
  has_many :game_modes, through: :game_mode_items

  has_many :game_platforms
  has_many :platforms, through: :game_platforms

  has_many :multiplayer_modes

  has_many :game_developers
  has_many :companies, through: :game_developers

  has_many :game_publishers
  has_many :companies, through: :game_publishers
end
