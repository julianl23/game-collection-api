class RemoveOriginalGameCollectionsAndUsers < ActiveRecord::Migration[5.2]

  # Drop the originally created Users and Game Collections tables
  # These will be regenerated after devise is installed

  def change
    drop_table :game_collections
    drop_table :users
  end
end
