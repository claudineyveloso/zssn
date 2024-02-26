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
            message: 'Nemesis informa: Usuário infectado! Lamentamos informar que, devido à sua condição de saúde, você não pode criar um novo item de inventário no momento!'
          }
        end

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
        params.require(:trade).permit(:giver_id,
                                      :receiver_id,
                                      giver_items: {},
                                      receiver_items: {})
      end
    end
  end
end
