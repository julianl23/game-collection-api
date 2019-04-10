# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :developers
  has_many :publishers
  has_many :games, through: :associated_developers
  has_many :games, through: :associated_publishers
end
