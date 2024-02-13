# frozen_string_literal: true

class RemoveIsActiveFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :is_active, :boolean
  end
end
