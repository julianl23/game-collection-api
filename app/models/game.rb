class Game < ApplicationRecord
  has_one :publisher
  has_one :developer
end
