# frozen_string_literal: true

class CreateGameCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :game_collections do |t|
      # t.references :user, foreign_key: true
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
