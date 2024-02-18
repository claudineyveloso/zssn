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
class ItemSerializer < ActiveModel::Serializer
  attributes :id,
             :description,
             :score
end
