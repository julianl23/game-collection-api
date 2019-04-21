class CreateGameModeItems < ActiveRecord::Migration[5.2]
  def change
    create_table :game_mode_items do |t|
      t.references :game, foreign_key: true
      t.references :game_mode, foreign_key: true

      t.timestamps
    end
  end
end
