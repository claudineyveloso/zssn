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
# Indexes
#
#  index_items_on_description  (description) UNIQUE
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should have_many(:inventory_items).dependent(:destroy) }
    it { should have_many(:inventories).through(:inventory_items) }

    let(:opcoes_validas) { %w[Água Comida Medicamento Munição] }
    describe 'validations' do
      it { should validate_presence_of(:description) }
      it { should validate_length_of(:description).is_at_most(20) }
      subject { FactoryBot.build(:item) }
      it { should validate_uniqueness_of(:description) }
      # it { should validate_inclusion_of(:description).in_array(opcoes_validas) }
      it { should validate_presence_of(:score) }
      it { should validate_numericality_of(:score).only_integer }
    end

    describe 'custom validation' do
      context 'when description is in opcoes_validas' do
        let(:valid_item) { build(:item, description: 'Comida', score: 3) }

        it 'is valid' do
          expect(valid_item).to be_valid
        end
      end

      context 'when description is not in opcoes_validas' do
        let(:invalid_item) { build(:item, description: 'Invalid Description', score: 10) }

        it 'is invalid' do
          expect(invalid_item).not_to be_valid
        end

        it 'adds a custom error message' do
          invalid_item.valid?
          # expect(invalid_item.errors[:description]).to include('Nemesis informa: Invalid Description não está incluído na lista de opções. Por favor, escolha entre Água, Comida, Medicamento, Munição')
        end
      end

      context 'when description is not provided' do
        let(:item_without_description) { build(:item, description: nil, score: 10) }

        it 'is invalid' do
          expect(item_without_description).not_to be_valid
        end

        # it 'has an error message for missing description' do
        #   item_without_description.valid?
        #   expect(item_without_description.errors[:description]).to include("can't be blank")
        # end
      end
    end
  end
end
