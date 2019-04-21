class CreateGameMultiplayerModes < ActiveRecord::Migration[5.2]
  def change
    create_table :game_multiplayer_modes do |t|
      t.references :game, foreign_key: true
      t.references :multiplayer_mode, foreign_key: true

      t.timestamps
    end
  end
end
