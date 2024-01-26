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
  describe 'associations' do
    it { should have_many(:inventories) }
    it do
      should have_many(:reporteds)
        .class_name('Infected')
        .dependent(:destroy)
        .with_foreign_key('user_id_reported')
    end

    it do
      should have_many(:notifieds)
        .class_name('Infected')
        .dependent(:destroy)
        .with_foreign_key('user_id_notified')
    end
  end

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

  describe '.infecteds' do
    it 'returns the count of infected users' do
      # Created some users to test
      User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                  infected: true)
      User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                  infected: true)
      User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                  infected: true)
      infected_count = User.infecteds
      expect(infected_count).to eq(3)

      # Running the infecteds scope
      infected_count = User.infecteds

      # expected 3
      expect(infected_count).to eq(3) # Deveria haver 3 usuários infectados
    end
  end

  describe '.percentual_infecteds' do
    it 'returns the percentage of infected users' do
      # Created some users to test
      User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                  infected: false)
      User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                  infected: false)
      User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                  infected: true)

      percentual_infected = User.percentual_infecteds(true)
      expect(percentual_infected).to eq(33.33333333333333)
    end
    it 'returns 0 when there are no users' do
      percentual_infected = User.percentual_infecteds(true)
      expect(percentual_infected).to eq(0)
    end
    it 'returns 0 when there are no infected users' do
      # Crie alguns usuários não infectados para testar
      User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                  infected: false)

      # Execute o escopo percentual_infecteds
      percentual_infected = User.percentual_infecteds(true)

      # Verifique se o resultado é 0 quando não há usuários infectados
      expect(percentual_infected).to eq(0)
    end
  end
end
