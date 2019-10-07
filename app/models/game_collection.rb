# frozen_string_literal: true

class GameCollection < ApplicationRecord
  belongs_to :user
  has_many :game_collection_items
end
