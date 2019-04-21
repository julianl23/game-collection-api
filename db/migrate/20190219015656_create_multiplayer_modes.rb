# frozen_string_literal: true

class CreateMultiplayerModes < ActiveRecord::Migration[5.2]
  def change
    create_table :multiplayer_modes do |t|
      t.references :platform
      t.boolean :offline_coop
      t.boolean :online_coop
      t.boolean :lan_coop
      t.boolean :campaign_coop
      t.boolean :splitscreen_online
      t.boolean :splitscreen
      t.boolean :drop_in
      t.integer :offline_coop_max
      t.integer :online_coop_max
      t.integer :online_max
      t.integer :offline_max

      t.timestamps
    end
  end
end
