# frozen_string_literal: true

# == Schema Information
#
# Table name: inventory_items
#
#  id           :bigint           not null, primary key
#  quantity     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  inventory_id :bigint           not null
#  item_id      :bigint           not null
#
# Indexes
#
#  index_inventory_items_on_inventory_id  (inventory_id)
#  index_inventory_items_on_item_id       (item_id)
#
# Foreign Keys
#
#  fk_rails_...  (inventory_id => inventories.id)
#  fk_rails_...  (item_id => items.id)
#
class InventoryItem < ApplicationRecord
  belongs_to :inventory
  belongs_to :item

  def self.average_quantity_per_user
    users_data = []
    # For each user, calculate the average quantity of each item
    User.includes(:inventory, :inventory_items).where(infected: false).find_each do |user|
      next unless user.inventory.present? && user.inventory.inventory_items.present?

      inventory_items = user.inventory.inventory_items.group(:item_id).sum(:quantity)
      user_data = {
        name: user.name,
        items: {}
      }
      inventory_items.each do |item_id, total_quantity|
        item_description = Item.find(item_id).description
        user_data[:items][item_description] = total_quantity
      end
      users_data << user_data
    end
    # average_quantity_per_user.to_json
    { data: { users: users_data } }
  end
end
