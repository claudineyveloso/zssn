# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  age                        :integer          not null
#  contamination_notification :integer          default(0)
#  gender                     :string(20)       not null
#  infected                   :boolean          default(FALSE)
#  is_active                  :boolean          default(TRUE)
#  latitude                   :string           not null
#  longitude                  :string           not null
#  name                       :string(100)      not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:gender) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }

    it {
      should validate_length_of(:name).is_at_most(100)
    }
    it {
      should validate_length_of(:gender).is_at_most(20)
    }
    it {
      should validate_length_of(:latitude).is_at_most(255)
    }
    it {
      should validate_length_of(:longitude).is_at_most(255)
    }
    it 'has a valid factory' do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end
  end
end
