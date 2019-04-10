# frozen_string_literal: true

class CreateGameModes < ActiveRecord::Migration[5.2]
  def change
    create_table :game_modes do |t|
      t.integer :igdb_id
      t.string :name

      t.timestamps
    end
  end
end
