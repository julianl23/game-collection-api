# frozen_string_literal: true

class Game < ApplicationRecord
  has_one :cover
  has_many :companies, through: :developers
  has_many :companies, through: :publishers
  has_many :game_modes
  has_many :platforms
  has_many :multiplayer_modes
end
