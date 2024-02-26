# frozen_string_literal: true

# trade
class Trade
  include ActiveModel::Model

  attr_accessor :giver_id,
                :giver_items,
                :receiver_id,
                :receiver_items

  def initialize(attributes = {})
    @giver_id = attributes[:giver_id]
    @giver_items = attributes[:giver_items]
    @receiver_id = attributes[:receiver_id]
    @receiver_items = attributes[:receiver_items]
  end

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
    { message: 'Troca realizada com sucesso' }
  end

  private

  def valid_items?(items)
    items.all? { |item_id, _| Item.exists?(item_id:) }
  end

  def validate_trade
    # checks if the inventory exists
    return if validate_inventory?

    # checks if the of giver item exists
    unless items_exist?(giver_id, giver_items)
      errors.add(:base, 'Nemesis informa: Alguns itens do doador da troca não existem no inventário.')
      return
    end

    # checks if the of receiver item exists
    unless items_exist?(receiver_id, receiver_items)
      errors.add(:base, 'Nemesis informa: Alguns itens do receptor da troca não existem no inventário.')
      return
    end

    return if total_scores(giver_items) == total_scores(receiver_items)

    errors.add(:base, 'Nemesis informa: Total de pontos dos itens trocados não são iguais.')
  end

  def validate_inventory?
    giver_inventory = Inventory.find_by(id: giver_id)
    receiver_inventory = Inventory.find_by(id: receiver_id)
    return false unless giver_inventory.nil? || receiver_inventory.nil?

    errors.add(:base, 'Nemesis informa: Um dos inventários informados não foi encontrado para realizar a troca de itens.')
  end

  def items_exist?(inventory_id, items)
    items.each_key do |item_id|
      return false unless InventoryItem.exists?(inventory_id:, item_id:)
    end
    true
  end

  def total_scores(items)
    total = 0
    items.each do |item_id, quantity|
      item = Item.find(item_id)
      total += (item.score * quantity.to_i)
    end
    total
  end

  def add_items(inventory_id, items)
    items.each do |item_id, quantity|
      InventoryItem.add_quantity(inventory_id, item_id, quantity.to_i)
    end
  end

  def remove_items(inventory_id, items)
    items.each do |item_id, quantity|
      InventoryItem.remove_quantity(inventory_id, item_id, quantity.to_i)
    end
  end
end
