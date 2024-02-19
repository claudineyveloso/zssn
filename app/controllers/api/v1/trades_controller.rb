# frozen_string_literal: true

module Api
  module V1
    # TradesController
    class TradesController < ApplicationController
      def create
        trade = Trade.new(trade_params)
        if trade.valid?
          trade.execute_trade
          render json: { message: 'Troca realizada com sucesso' }, status: :ok
        else
          render json: { error: trade.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def trade_params
        params.require(:trade).permit(:user_giver,
                                      :user_receiver,
                                      item_user_giver: {},
                                      item_user_receiver: {})
      end
    end
  end
end
