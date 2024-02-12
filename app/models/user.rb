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
class User < ApplicationRecord
  has_one :inventory
  has_many :reporteds, class_name: 'Infected', dependent: :destroy, foreign_key: 'user_id_reported'
  has_many :notifieds, class_name: 'Infected', dependent: :destroy, foreign_key: 'user_id_notified'

  scope :infecteds, -> { where(infected: true).count }
  scope :percentual_infecteds, lambda { |infected|
    users = count
    infecteds = where(infected:).count
    percentual = users.zero? ? 0 : (infecteds.to_f / users * 100).round(2)
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
