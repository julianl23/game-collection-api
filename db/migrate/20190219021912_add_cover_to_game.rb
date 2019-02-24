class AddCoverToGame < ActiveRecord::Migration[5.2]
  def change
    add_reference :games, :cover
  end
end
