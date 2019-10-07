# frozen_string_literal: true

json.id @game_collection.id
json.user_id @game_collection.user_id
json.count @game_collection.game_collection_items.count

json.items @game_collection.game_collection_items do |item|
  json.id item.id
  json.cost item.cost
  json.borrowed item.is_borrowed

  json.note do
    json.text item.note_text
    json.is_private item.is_private_note
  end

  json.details do
    json.call(item, :has_cart_disk_item, :has_case_box, :has_manual)
    json.has_other_inserts item.has_other_items
  end

  json.game do
    json.id item.game.id
    json.title item.game.title
    json.description item.game.description
    json.release_date item.game.release_date
    json.igdb_id item.game.igdb_id
  end

  json.platform do
    json.id item.platform.id
    json.name item.platform.name
    json.igdb_id item.platform.name
  end
end