# frozen_string_literal: true

class Game < ApplicationRecord
  has_one :cover

  has_many :game_mode_items
  has_many :game_modes, through: :game_mode_items

  has_many :game_platforms
  has_many :platforms, through: :game_platforms

  has_many :multiplayer_modes

  has_many :game_developers
  has_many :companies, through: :game_developers

  has_many :game_publishers
  has_many :companies, through: :game_publishers

  paginates_per 20

  def as_json(*)
    super(except: [:created_at, :updated_at], include: {
      multiplayer_modes: {},
      platforms: {},
      game_modes: {},
      game_developers: {
        include: %i[company]
      },
      game_publishers: {
        include: %i[company]
      },
      cover: {}
    })
  end
end
