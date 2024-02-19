# frozen_string_literal: true

# trade
class Trade
  include ActiveModel::Model

  attr_accessor :giver_id,
                :giver_items,
                :receiver_id,
                :receiver_items

  validates :giver_id,
            :giver_items,
            :receiver_id,
            :receiver_items,
            presence: true
  validate :validate_trade
  def execute_trade
    add_items(giver_id, receiver_items)
    remove_items(receiver_id, receiver_items)

    add_items(receiver_id, giver_items)
    remove_items(giver_id, giver_items)
  end

  private

  def validate_trade
    errors.add(:base, 'Total de pontos dos itens trocados não são iguais') unless total_scores(giver_items) == total_scores(receiver_items)
  end

  def total_scores(items)
    items.sum { |item_id, quantity| Item.find(item_id).points * quantity.to_i }
  end

  def add_items(user_id, items)
    items.each do |item_id, quantity|
      InventoryItem.add_quantity(user_id, item_id, quantity.to_i)
    end
  end

  def remove_items(user_id, items)
    items.each do |item_id, quantity|
      InventoryItem.remove_quantity(user_id, item_id, quantity.to_i)
    end
  end
  def fsafdsafsa

  end
end
