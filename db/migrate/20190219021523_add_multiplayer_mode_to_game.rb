class AddMultiplayerModeToGame < ActiveRecord::Migration[5.2]
  def change
    add_reference :games, :multiplayer_mode
  end
end
