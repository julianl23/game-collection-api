# frozen_string_literal: true

class GameMode < ApplicationRecord
  has_many :game_mode_items
  has_many :games, through: :game_mode_items
end
