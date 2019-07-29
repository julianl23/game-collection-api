# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :game_developers
  has_many :games, through: :game_developers

  has_many :game_publishers
  has_many :games, through: :game_publishers

  def as_json(*)
    super(except: %i[created_at updated_at])
  end
end
