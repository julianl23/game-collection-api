class GamePublisher < ApplicationRecord
  belongs_to :game
  belongs_to :company

  def as_json(*)
    super(except: %i[created_at updated_at])
  end
end
