class AddPlatformToGame < ActiveRecord::Migration[5.2]
  def change
    add_reference :games, :platform
  end
end
