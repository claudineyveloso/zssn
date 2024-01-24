# frozen_string_literal: true

# Inventory is a model that represents user item inventories.
# Includes user_id and item_id attributes.
# It also guarantees validations for data integrity.
class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
