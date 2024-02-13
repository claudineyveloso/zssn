# frozen_string_literal: true

# == Schema Information
#
# Table name: infecteds
#
#  user_id_notified :bigint
#  user_id_reported :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (user_id_notified => users.id)
#  fk_rails_...  (user_id_reported => users.id)
#
class InfectedSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id_reported,
             :user_id_notified
end
