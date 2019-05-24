class CreateGameCollectionItems < ActiveRecord::Migration[5.2]
  def change
    create_table :game_collection_items do |t|
      t.references :game_collection, foreign_key: true
      t.references :game, foreign_key: true
      t.references :platform, foreign_key: true

      t.boolean :is_borrowed
      t.money :cost

      # note
      t.text :note_text
      t.boolean :is_private_note

      # details
      t.boolean :has_cart_disk_item
      t.boolean :has_case_box
      t.boolean :has_manual
      t.boolean :has_other_items
    end
  end
end