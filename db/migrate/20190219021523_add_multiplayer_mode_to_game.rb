# frozen_string_literal: true

class AddMultiplayerModeToGame < ActiveRecord::Migration[5.2]
  def change
    add_reference :games, :multiplayer_mode
  end
end
