# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  age                        :integer          not null
#  contamination_notification :integer          default(0)
#  gender                     :string(20)       not null
#  infected                   :boolean          default(FALSE), not null
#  latitude                   :string           not null
#  longitude                  :string           not null
#  name                       :string(100)      not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one(:inventory).dependent(:destroy) }
    it { should delegate_method(:inventory_items).to(:inventory) }
    it { should have_many(:inventory_items).through(:inventory) }
    it { should have_many(:reporteds).class_name('Infected').with_foreign_key('user_id_reported').dependent(:destroy) }
    it { should have_many(:notifieds).class_name('Infected').with_foreign_key('user_id_notified').dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:gender) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }

    it { should validate_length_of(:name).is_at_most(100) }
    it { should validate_length_of(:gender).is_at_most(20) }
    it { should validate_length_of(:latitude).is_at_most(255) }
    it { should validate_length_of(:longitude).is_at_most(255) }
  end

  describe 'scopes' do
    describe '.infected' do
      let!(:infected_user) { create(:user, infected: true) }
      let!(:uninfected_user) { create(:user, infected: false) }

      it 'returns infected user with given id' do
        expect(User.infected(infected_user.id).first).to eq(infected_user)
      end

      it 'does not return uninfected user' do
        expect(User.infected(uninfected_user.id).first).to be_nil
      end
    end
  end

  describe '.percentual_infecteds' do
    let!(:infected_users) { create_list(:user, 3, infected: true) }
    let!(:uninfected_users) { create_list(:user, 2, infected: false) }
    it 'returns the percentage of infected users and their details' do
      result = User.percentual_infecteds(true)
      expect(result[:data][:percentage]).to eq('60.00%')
      expect(result[:data][:users].size).to eq(3)
      expect(result[:data][:users].first.keys).to contain_exactly(:name, :age, :gender, :latitude, :longitude, :infected, :contamination_notification)
    end
  end

  describe '.lost_score' do
    let!(:infected_users) { create_list(:user, 3, :with_inventory, infected: true) }
    let!(:uninfected_users) { create_list(:user, 2, infected: false) }

    it 'returns data of infected users with their lost score' do
      expected_score = infected_users.sum { |user| user.inventory_items.sum(&:score_times_quantity) }

      result = User.lost_score

      # Check if the returned data is a hash containing a 'data' key
      expect(result).to be_a(Hash)
      expect(result.keys).to contain_exactly(:data)

      # Check if the 'data' key contains a 'users' key which is an array
      expect(result[:data]).to be_a(Hash)
      expect(result[:data].keys).to contain_exactly(:users)
      expect(result[:data][:users]).to be_an(Array)

      # Verify that the number of infected users returned matches the number created
      expect(result[:data][:users].size).to eq(3)

      # Verify that each user has the expected data keys and that the score is correct
      result[:data][:users].each do |user_data|
        expect(user_data.keys).to contain_exactly(:name, :age, :gender, :latitude, :longitude, :infected, :contamination_notification, :score)

        # Find the corresponding user in the infected users
        user = infected_users.find { |u| u.name == user_data[:name] }

        # Check whether the score calculated for the user is correct
        expect(user_data[:score]).to eq(user.inventory_items.sum(&:score_times_quantity))
      end

      # Check whether the total score returned by the method is correct
      total_score = result[:data][:users].sum { |user_data| user_data[:score] }
      expect(total_score).to eq(expected_score)
    end
  end
end
