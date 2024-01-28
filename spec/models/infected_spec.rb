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
    it { should belong_to(:user) }
  end
end
