class ChangeMultiplayerModeRelationship < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :multiplayer_modes, :game
    add_belongs_to :multiplayer_modes, :platform
  end
end
