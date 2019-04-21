class GameModeItem < ApplicationRecord
  belongs_to :game
  belongs_to :game_mode
end
