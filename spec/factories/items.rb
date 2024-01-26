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
FactoryBot.define do
  factory :item do
    description { 'Medicamento' }
    score { 2 }
  end
end