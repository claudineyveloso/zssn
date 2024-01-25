# frozen_string_literal: true

class CreateInfecteds < ActiveRecord::Migration[7.1]
  def change
    create_table :infecteds, id: false do |t|
      t.bigint :user_id_reported
      t.bigint :user_id_notified

      t.timestamps
    end

    add_foreign_key :infecteds, :users, column: :user_id_reported
    add_foreign_key :infecteds, :users, column: :user_id_notified
  end
end
