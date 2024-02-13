# == Schema Information
#
# Table name: inventories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_inventories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Inventory < ApplicationRecord
  belongs_to :user
  has_many :inventory_items, dependent: :destroy
  has_many :items, through: :inventory_items
  validates :user_id, presence: true

  def trade_items(other_user)
    return unless other_user.is_a?(User)

    current_items_score = items.sum(:score)
    other_items_score = other_user.inventory.items.sum(:score)

    return unless current_items_score == other_items_score

    ActiveRecord::Base.transaction do
      items.destroy_all
      other_user.inventory.items.destroy_all

      Item.where(score: current_items_score).each do |item|
        inventory_items.create(item: item)
      end

      Item.where(score: other_items_score).each do |item|
        other_user.inventory.inventory_items.create(item: item)
      end
    end
    true
  end
end
