# frozen_string_literal: true

class Publisher < ApplicationRecord
  belongs_to :game
  belongs_to :company
end
