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
require 'rails_helper'

RSpec.describe InventoryItem, type: :model do
  let!(:inventory) { create(:inventory) }
  let!(:item) { create(:item) }
  let!(:inventory_item) { create(:inventory_item, inventory:, item:, quantity: 10) }

  describe 'associations' do
    it { should belong_to(:inventory) }
    it { should belong_to(:item) }
  end

  describe '.add_quantity' do
    it 'adds quantity to the inventory item' do
      expect do
        InventoryItem.add_quantity(inventory.id, item.id, 5)
      end.to change { inventory_item.reload.quantity }.by(5)
    end
  end

  describe '.remove_quantity' do
    it 'removes quantity from the inventory item' do
      expect do
        InventoryItem.remove_quantity(inventory.id, item.id, 3)
      end.to change { inventory_item.reload.quantity }.by(-3)
    end
  end
end
