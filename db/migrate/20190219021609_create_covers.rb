# frozen_string_literal: true

class CreateCovers < ActiveRecord::Migration[5.2]
  def change
    create_table :covers do |t|
      t.string :url
      t.string :cloudinary_id
      t.integer :width
      t.integer :height
      t.references :game

      t.timestamps
    end
  end
end
