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
class Item < ApplicationRecord
  has_many :inventories
  validates :description,
            presence: true,
            length: { maximum: 20 },
            inclusion: { in: %w[Água Comida Medicamento Munição],
                         message: 'Nemesis informa: Descrição inválida para este item!' }
  validates :score,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
