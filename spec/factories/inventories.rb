# == Schema Information
#
# Table name: inventories
#
#  id         :bigint           not null, primary key
#  items      :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_inventories_on_items    (items) USING gin
#  index_inventories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :inventory do
    user { nil }
    item { nil }
  end
end
