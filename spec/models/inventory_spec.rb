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
require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:item) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:item_id) }
  end
end
