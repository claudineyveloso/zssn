# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :description, null: false
      t.integer :score, null: false

      t.timestamps
    end
  end
end
