# frozen_string_literal: true

class Developer < ApplicationRecord
  belongs_to :game
  belongs_to :company
end
