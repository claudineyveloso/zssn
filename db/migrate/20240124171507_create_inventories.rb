# frozen_string_literal: true

# Inventory is a model that represents user item inventories.
# Includes user_id attribute.
# It also guarantees validations for data integrity.
class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :items, null: false, default: {}
      t.timestamps
    end
    add_index :inventories, :items, using: :gin
  end
end
