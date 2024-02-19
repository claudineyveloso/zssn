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
    description { %w[Água Comida Medicamento Munição].sample }
    score { [4, 3, 2, 1].sample }
  end
end
