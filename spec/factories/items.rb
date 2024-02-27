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
FactoryBot.define do
  factory :item do
    description { 'Água' }
    score { 4 }

    trait :agua do
      description { 'Água' }
      score { 4 }
    end

    trait :comida do
      description { 'Comida' }
      score { 3 }
    end

    trait :medicamento do
      description { 'Medicamento' }
      score { 2 }
    end

    trait :municao do
      description { 'Munição' }
      score { 1 }
    end
  end
end
