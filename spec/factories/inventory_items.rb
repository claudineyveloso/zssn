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
FactoryBot.define do
  factory :inventory_item do
    quantity { Faker::Number.between(from: 1, to: 10) }
    association :inventory
    association :item

    trait :agua do
      association :item, factory: %i[item agua]
    end
    trait :comida do
      association :item, factory: %i[item comida]
    end
  end
end
