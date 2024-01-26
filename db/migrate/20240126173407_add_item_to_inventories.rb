# frozen_string_literal: true

class AddItemToInventories < ActiveRecord::Migration[7.1]
  def change
    add_reference :inventories, :item, null: false, foreign_key: true
  end
end
