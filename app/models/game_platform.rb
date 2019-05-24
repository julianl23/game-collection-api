class GamePlatform < ApplicationRecord
  belongs_to :game
  belongs_to :platform

  validates_uniqueness_of :platform_id, :scope => :game_id, :message => 'platform already exists for this game'
end
