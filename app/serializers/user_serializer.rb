# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  age                        :integer          not null
#  contamination_notification :integer          default(0)
#  gender                     :string(20)       not null
#  infected                   :boolean          default(FALSE)
#  latitude                   :string           not null
#  longitude                  :string           not null
#  name                       :string(100)      not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :age,
             :gender,
             :latitude,
             :longitude,
             :infected,
             :contamination_notification,
             :created_at,
             :updated_at
end
