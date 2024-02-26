# frozen_string_literal: true

class AddUniqueIndexToDescriptionOnItem < ActiveRecord::Migration[7.1]
  def change
    add_index :items, :description, unique: true
  end
end
