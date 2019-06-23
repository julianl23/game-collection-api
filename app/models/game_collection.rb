# frozen_string_literal: true

class GameCollection < ApplicationRecord
  belongs_to :user
  has_many :games, through: :game_collection_item
end
