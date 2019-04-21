class DropGameMultiplayerModes < ActiveRecord::Migration[5.2]
  def change
    drop_table :game_multiplayer_modes
  end
end
