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
  let(:inventory_id) { inventory_item.inventory_id }
  let(:item_id) { inventory_item.item_id }

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

    context 'when inventory item exists' do
      it 'removes quantity from the inventory item' do
        InventoryItem.remove_quantity(inventory_id, item_id, 5)
        expect(inventory_item.reload.quantity).to eq(5)
      end

      it 'does not allow quantity to become negative' do
        InventoryItem.remove_quantity(inventory_id, item_id, 20)
        expect(inventory_item.reload.quantity).to eq(0)
      end
    end

    context 'when inventory item does not exist' do
      it 'does not raise error' do
        expect { InventoryItem.remove_quantity(9999, 9999, 5) }.not_to raise_error
      end
    end
  end

  describe '.average_quantity_per_user' do
    let!(:user1) { create(:user, name: 'User 1', infected: false) }
    let!(:user2) { create(:user, name: 'User 2', infected: false) }
    let!(:item1) { create(:item, :comida) }
    let!(:item2) { create(:item, :medicamento) }
    let!(:inventory1) { create(:inventory, user: user1) }
    let!(:inventory2) { create(:inventory, user: user2) }
    let!(:inventory_item1_user1_item1) { create(:inventory_item, inventory: inventory1, item: item1, quantity: 5) }
    let!(:inventory_item2_user1_item2) { create(:inventory_item, inventory: inventory1, item: item2, quantity: 10) }
    let!(:inventory_item1_user2_item1) { create(:inventory_item, inventory: inventory2, item: item1, quantity: 8) }
    let!(:inventory_item2_user2_item2) { create(:inventory_item, inventory: inventory2, item: item2, quantity: 12) }

    it 'calculates the average quantity of each item for each user' do
      result = InventoryItem.average_quantity_per_user

      expect(result[:data][:users].size).to eq(3)

      user1_data = result[:data][:users].find { |user| user[:name] == 'User 1' }
      expect(user1_data[:items]['Comida']).to eq(5)
      expect(user1_data[:items]['Medicamento']).to eq(10)

      user2_data = result[:data][:users].find { |user| user[:name] == 'User 2' }
      expect(user2_data[:items]['Comida']).to eq(8)
      expect(user2_data[:items]['Medicamento']).to eq(12)
    end
  end
end
