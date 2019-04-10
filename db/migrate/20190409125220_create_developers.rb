# frozen_string_literal: true

class CreateDevelopers < ActiveRecord::Migration[5.2]
  def change
    create_table :developers do |t|
      t.integer :company_id
      t.integer :game_id

      t.timestamps
    end
  end
end
