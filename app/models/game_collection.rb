# frozen_string_literal: true

class GameCollection < ApplicationRecord
  belongs_to :user
  has_many :games
end
