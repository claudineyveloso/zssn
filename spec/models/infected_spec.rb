# frozen_string_literal: true

# == Schema Information
#
# Table name: infecteds
#
#  user_id_notified :bigint
#  user_id_reported :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id_notified => users.id)
#  fk_rails_...  (user_id_reported => users.id)
#
require 'rails_helper'

RSpec.describe Infected, type: :model do
  describe 'associations' do
    it 'belongs to a notified user' do
      should belong_to(:user).class_name('User').with_foreign_key('user_id_notified')
    end
  end
end
