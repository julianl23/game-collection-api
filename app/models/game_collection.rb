# frozen_string_literal: true

class GameCollection < ApplicationRecord
  has_one :user
  has_many :games, through: :game_collection_item
end
