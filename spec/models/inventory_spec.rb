# frozen_string_literal: true

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
require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'Associations' do
    it 'belongs to a user' do
      should belong_to(:user)
    end

    it 'has many inventory items' do
      should have_many(:inventory_items).dependent(:destroy)
    end

    it 'There are many items through inventory_items' do
      should have_many(:items).through(:inventory_items)
    end
  end

  describe 'Validations' do
    it { should validate_presence_of(:user_id) }
  end
end
