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
#  latitude                   :string(255)      not null
#  longitude                  :string(255)      not null
#  name                       :string(100)      not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    age { Faker::Number.between(from: 18, to: 99) }
    gender { 'Male' }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
