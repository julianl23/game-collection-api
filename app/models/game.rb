class Game < ApplicationRecord
  has_one :cover
  has_one :publisher
  has_one :developer
  has_many :game_modes
  has_many :platforms
  has_many :multiplayer_modes
end
