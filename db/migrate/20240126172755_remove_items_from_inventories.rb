# frozen_string_literal: true

class RemoveItemsFromInventories < ActiveRecord::Migration[7.1]
  def change
    remove_column :inventories, :items, :jsonb
  end
end
