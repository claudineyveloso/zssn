# frozen_string_literal: true

# User is a model representing individual users in the system.
# It includes attributes like name, age, gender and more.
# Also ensure validations to data integrity.
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 100, null: false
      t.integer :age, null: false
      t.string :gender, limit: 20, null: false
      t.string :latitude, null: false
      t.string :longitude, null: false
      t.boolean :infected, default: false, null: false
      t.integer :contamination_notification, default: 0
      t.boolean :is_active, default: true, null: false
      t.timestamps
    end
  end
end
