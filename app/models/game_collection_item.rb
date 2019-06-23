class GameCollectionItem < ApplicationRecord
  belongs_to :game_collection
  belongs_to :game
  has_one :platform


  # Fields:
  # game
  # platform
  # is borrowed
  # cost
  # note_text
  # is_private_note
  # has_cart_disk_item
  # has_case_box
  # has_manual
  # has_other_items

end
