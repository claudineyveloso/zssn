# frozen_string_literal: true

class InventoryItemSerializer < ActiveModel::Serializer
  attributes :id,
             :inventory_id,
             :item_id,
             :quantity,
             :created_at,
             :updated_at
end
