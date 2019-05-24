class RemoveCoverFromGame < ActiveRecord::Migration[5.2]
  def change
    remove_reference :games, :cover
  end
end
