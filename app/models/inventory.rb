# == Schema Information
#
# Table name: inventories
#
#  id         :bigint           not null, primary key
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_inventories_on_item_id  (item_id)
#  index_inventories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (user_id => users.id)
#
class Inventory < ApplicationRecord
  belongs_to :user
  belongs_to :item
  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :quantity, presence: true
end
