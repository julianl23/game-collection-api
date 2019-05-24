class GameCollectionItem < ApplicationRecord
  belongs_to :game_collection
  belongs_to :game
  has_one :platform
end
