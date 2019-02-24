class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.integer :igdb_id
      t.string :name
      t.text :description
      t.string :type, null: false

      t.timestamps
    end
  end
end
