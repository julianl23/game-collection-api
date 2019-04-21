class ChangeCover < ActiveRecord::Migration[5.2]
  def change
    remove_column :covers, :cloudinary_id
    add_column :covers, :igdb_id, :integer
    add_column :covers, :igdb_image_id, :string
  end
end
