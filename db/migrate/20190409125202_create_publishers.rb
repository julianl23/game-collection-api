# frozen_string_literal: true

class CreatePublishers < ActiveRecord::Migration[5.2]
  def change
    create_table :publishers do |t|
      t.integer :company_id
      t.integer :game_id

      t.timestamps
    end
  end
end
