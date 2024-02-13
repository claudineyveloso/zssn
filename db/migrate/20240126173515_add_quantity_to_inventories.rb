# frozen_string_literal: true

class AddQuantityToInventories < ActiveRecord::Migration[7.1]
  def change
    add_column :inventories, :quantity, :integer
  end
end
