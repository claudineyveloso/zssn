# frozen_string_literal: true

class Item < ApplicationRecord
  validates :description,
            presence: true,
            inclusion: { in: %w[Água Comida Medicamento Munição],
                         message: 'Nemesis informa: Descrição inválida para este item!' }
  validates :score,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
