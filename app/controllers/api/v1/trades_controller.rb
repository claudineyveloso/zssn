# frozen_string_literal: true

module Api
  module V1
    class TradesController < ApplicationController
      before_action :set_user
      def create
        other_user = User.find(params[:other_user_id])
        @user.inventory.trade_items(other_user.inventory)

        head :no_content
      end

      private

      def set_user
        User.find(params[:user_id])
      end
    end
  end
end
