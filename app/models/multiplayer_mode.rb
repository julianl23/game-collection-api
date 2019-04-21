# frozen_string_literal: true

class MultiplayerMode < ApplicationRecord
  belongs_to :game
  belongs_to :platform
end
