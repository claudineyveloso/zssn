# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  description :string(20)       not null
#  score       :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should have_many(:inventories) }
  end

  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:score) }

    it {
      should validate_length_of(:description).is_at_most(20)
    }
    it 'is valid with a valid description' do
      valid_descriptions = %w[Água Comida Medicamento Munição]
      valid_descriptions.each do |description|
        item = build(:item, description:)
        expect(item).to be_valid
      end
    end
    it 'is not valid with an invalid description' do
      invalid_description = 'InvalidDescription'
      item = build(:item, description: invalid_description)
      expect(item).not_to be_valid
      expect(item.errors[:description]).to include('Nemesis informa: Descrição inválida para este item!')
    end
  end
  describe 'validations' do
    it { should validate_presence_of(:score) }
    it { should validate_numericality_of(:score).only_integer.is_greater_than_or_equal_to(0) }
  end
end
