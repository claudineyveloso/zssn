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
  has_many :infecteds_user_id_reported, class_name: 'Infected', foreign_key: 'user_id_reported'
  has_many :infecteds_user_id_notified, class_name: 'Infected', foreign_key: 'user_id_notified'

  has_many :friendships_user1, through: :infecteds_user_id_reported, source: :user_id_reported
  has_many :friendships_user2, through: :infecteds_user_id_notified, source: :user_id_notified

  #######################################
  # has_many :friendships_user1, class_name: 'Friendship', foreign_key: 'user1_id'
  # has_many :friendships_user2, class_name: 'Friendship', foreign_key: 'user2_id'

  # has_many :friends_user1, through: :friendships_user1, source: :user2
  # has_many :friends_user2, through: :friendships_user2, source: :user1

  #       t.bigint :user_id_reported
  #     t.bigint :user_id_notified
  #
  scope :infecteds, -> { where(infected: true).count }
  scope :percentual_infecteds, lambda { |infected|
    users = count
    infecteds = where(infected:).count
    percentual = users.zero? ? 0 : (infecteds.to_f / users) * 100
  }

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
