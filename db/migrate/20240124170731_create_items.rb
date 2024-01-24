# frozen_string_literal: true

#
# Item is a model representing items of user in the system.
# Includes description and score attributes.
# It also ensure validations for data integrity..
class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :description, limit: 100, null: false
      t.integer :score, null: false

      t.timestamps
    end
  end
end
