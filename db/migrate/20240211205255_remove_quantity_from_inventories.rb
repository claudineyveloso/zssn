# frozen_string_literal: true

# This migration aims to remove the quantity column from the inventories table.
class RemoveQuantityFromInventories < ActiveRecord::Migration[7.1]
  def change
    remove_column :inventories, :item_id, :bigint
    remove_column :inventories, :quantity, :integer
  end
end
