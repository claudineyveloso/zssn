# frozen_string_literal: true

module Api
  module V1
    # TradesController
    class TradesController < ApplicationController
      def create
        # checks that the user giver is not infected
        user_giver = User.infected?(params[:trade][:giver_id])
        # checks that the user receiver is not infected
        user_receiver = User.infected?(params[:trade][:receiver_id])

        if user_giver.present? || user_receiver.present?
          return render json: {
            data: {
              user_giver:,
              user_receiver:
            },
            message: 'Usuário infectado! Lamentamos informar que, devido à sua condição de saúde, você não pode criar um novo item de inventário no momento!'
          }
        end

        trade = Trade.new(trade_params)

        if trade.valid?
          trade.execute_trade
          user_giver = User.find(params[:trade][:giver_id])
          inventory_giver = Inventory.find_by(user_id: params[:trade][:giver_id])
          inventory_items_giver = InventoryItem.includes(:item).where(inventory_id: inventory_giver.id)
          items_giver_hash = inventory_items_giver.map { |inventory_item| { inventory_item.item.description => inventory_item.quantity } }.reduce({}, :merge)

          user_receiver = User.find(params[:trade][:receiver_id])
          inventory_receiver = Inventory.find_by(user_id: params[:trade][:receiver_id])
          inventory_items_receiver = InventoryItem.includes(:item).where(inventory_id: inventory_receiver.id)
          items_receiver_hash = inventory_items_receiver.map { |inventory_item| { inventory_item.item.description => inventory_item.quantity } }.reduce({}, :merge)

          render json: {
                   user_giver: { name: user_giver.name },
                   inventory_giver: {
                     id: inventory_items_giver.first.inventory_id
                   },
                   inventory_items_giver: {
                     items: items_giver_hash
                   },

                   user_receiver: { name: user_receiver.name },
                   inventory_receiver: {
                     id: inventory_items_receiver.first.inventory_id
                   },
                   inventory_items_receiver: {
                     items: items_receiver_hash
                   },
                   message: 'Troca realizada com sucesso'
                 },

                 status: :ok
        else
          render json: { error: trade.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def trade_params
        params.require(:trade).permit(:giver_id,
                                      :receiver_id,
                                      giver_items: {},
                                      receiver_items: {})
      end
    end
  end
end
