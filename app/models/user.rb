# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                         :bigint           not null, primary key
#  age                        :integer          not null
#  contamination_notification :integer          default(0)
#  gender                     :string(20)       not null
#  infected                   :boolean          default(FALSE), not null
#  latitude                   :string           not null
#  longitude                  :string           not null
#  name                       :string(100)      not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class User < ApplicationRecord
  has_one :inventory, dependent: :destroy
  has_many :reporteds, class_name: 'Infected', dependent: :destroy, foreign_key: 'user_id_reported'
  has_many :notifieds, class_name: 'Infected', dependent: :destroy, foreign_key: 'user_id_notified'
  

  scope :infected, ->(id) { where(infected: true, id:) }
  # scope :infecteds, -> { where(infected: true).count }
  scope :percentual_infecteds, lambda { |infected|
    users = count
    infected_data = where(infected:)
    infecteds = infected_data.count
    percentage = users.zero? ? 0 : (infecteds.to_f / users * 100).round(2)
    infected_users_data = infected_data.map do |user|
      {
        name: user.name,
        age: user.age,
        gender: user.gender,
        latitude: user.latitude,
        longitude: user.longitude,
        infected: user.infected,
        contamination_notification: user.contamination_notification
      }
    end

    {
      data: {
        percentage: "#{sprintf('%.2f', percentage)}%",
        users: infected_users_data
      }
    }
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

  validate :valid_id_exists?, on: :destroy

  def create_inventory
    Inventory.create(user: self)
  end

  private

  def valid_id_exists?
    errors.add(:base, 'Nemesis informa: ID do usuário não encontrado') unless self.class.exists?(id)
  end
end
