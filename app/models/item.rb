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
class Item < ApplicationRecord
  has_many :inventory_items, dependent: :destroy
  has_many :inventories, through: :inventory_items

  opcoes_validas = %w[Água Comida Medicamento Munição]

  validates :description,
            presence: true,
            length: { maximum: 20 },
            uniqueness: true,
            inclusion: { in: opcoes_validas, message: lambda { |object, _|
                                                        "#{object.description} #{I18n.t('errors.messages.inclusion')}. Por favor, escolha entre #{opcoes_validas.join(', ')}"
                                                      } }
  validates :score, numericality: { only_integer: true }

  validates :score,
            presence: true,
            numericality: { only_integer: true,
                            message: ->(object, _) { "Pontos #{object.score} #{I18n.t('errors.messages.not_a_number')}!" } }

  validate :valid_description_with_score, if: -> { %w[Água Comida Medicamento Munição].include?(description) }

  private

  def valid_description_with_score
    score_by_description = {
      'Água' => 4,
      'Comida' => 3,
      'Medicamento' => 2,
      'Munição' => 1
    }
    return unless description && score != score_by_description[description]

    errors.add(:description,
               ['Não corresponde aos pontos esperados. Ex: [Água - 4 pontos] --- [Comida - 3 pontos] --- [Medicamento - 2 pontos] --- [Munição - 1 pontos] '].join("\n"))
  end
end
