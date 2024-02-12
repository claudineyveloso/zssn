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
            numericality: { only_integer: true,
              message: 'Nemesis informa: Score não pode ser uma string!' }

  validate :valid_description_with_score, if: -> { %w[Água Comida Medicamento Munição].include?(description) }

  private

  def valid_description_with_score
    score_by_description = {
      'Água' => 4,
      'Comida' => 3,
      'Medicamento' => 2,
      'Munição' => 1
    }
    if description && score != score_by_description[description]
      errors.add(:description, ["Nemesis informa: Não corresponde aos pontos esperados. Ex: [Água - 4 pontos] --- [Comida - 3 pontos] --- [Medicamento - 2 pontos] --- [Munição - 1 pontos] "].join("\n"))
    end
  end
end
