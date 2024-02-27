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
  context 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(20) }
    # it { should validate_uniqueness_of(:description) }
    it { should validate_numericality_of(:score).only_integer }
  end

  context 'description with score validation' do
    it 'allows valid descriptions with correct scores' do
      valid_items = { 'Água' => 4, 'Comida' => 3, 'Medicamento' => 2, 'Munição' => 1 }
      valid_items.each do |description, score|
        item = build(:item, description:, score:)
        expect(item).to be_valid
      end
    end

    it 'rejects descriptions with incorrect scores' do
      invalid_items = { 'Água' => 3, 'Comida' => 5, 'Medicamento' => 1, 'Munição' => 0 }
      invalid_items.each do |description, score|
        item = build(:item, description:, score:)
        expect(item).not_to be_valid
        expect(item.errors[:description]).to include('Não corresponde aos pontos esperados. Ex: [Água - 4 pontos] --- [Comida - 3 pontos] --- [Medicamento - 2 pontos] --- [Munição - 1 pontos] ')
      end
    end
  end
end
