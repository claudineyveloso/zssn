# frozen_string_literal: true

module Api
  module V1
    # TradesController
    class TradesController < ApplicationController
      before_action :set_user
      def create
        user_giver = User.find(trade_params[:user_giver])
        user_receiver = User.find(trade_params[:user_receiver])
        items_giver = Item.find(trade_params[:items_giver])
        items_receiver = Item.find(trade_params[:item_receiver])

        if valid_trade?(user_giver, items_giver, user_receiver, items_receiver)
          Trade.transaction do
            items_giver.each { |item| exchange_items(user_giver, user_receiver, item) }
            items_receiver.each { |item| exchange_items(user_receiver, user_giver, item) }
            items
          end
          render json: { message: 'Trade successful' }, status: :ok
        else
          render json: { message: 'Invalid trade request' }, status: :unprocessable_entity
        end
      end

      private

      def trade_params
        params.require(:trade).permit(:user_giver, :user_receiver, items_giver: [], item_receiver: [])
      end

      def valide_trade?(user_giver, items_giver, user_receiver, items_receiver)
        total_score(user_giver, items_giver) == total_score(user_receiver, items_receiver)
      end

      def total_score(_user, items)
        # items.sum {|item| item.score * params[`"quantity_#{item.id}".to_sym].to_i }
        items.sum { |item| item.score * params[`"quantity_#{item.id}"`].to_i }
      end

      def exchange_items(giver, receiver, item)
        giver.inventory.remove_item(item)
        receiver.inventory.remove_item(item)
      end

      def set_user
        User.find(params[:user_id])
      end
    end
  end
end
