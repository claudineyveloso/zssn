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
class InventorySerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :items

  # def serializable_hash
  #   super.transform_keys(&:to_sym)
  # end
end
