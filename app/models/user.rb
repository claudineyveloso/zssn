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
#  is_active                  :boolean          default(TRUE)
#  latitude                   :string           not null
#  longitude                  :string           not null
#  name                       :string(100)      not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class User < ApplicationRecord
  validates :name,
            length: { maximum: 100 },
            presence: true

  validates :age,
            presence: true

  validates :gender,
            length: { maximum: 20 },
            presence: true

  validates :latitude,
            length: { maximum: 255 },
            presence: true

  validates :longitude,
            length: { maximum: 255 },
            presence: true
end
