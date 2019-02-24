class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.datetime :release_date
      t.integer :igdb_id
      t.references :developer
      t.references :publisher
      t.references :game_mode

      t.timestamps
    end
  end
end
