# frozen_string_literal: true

module Api
  module V1
    # ItemsController is responsible for handling item-related actions,
    # In this controller we will only have the create method.
    class ItemsController < ApplicationController
      def index
        items = Item.all.order(description: :asc)
        # users = User.all.order(email: :asc)
        render json: items, status: 200, each_serializer: ItemSerializer
      end

      def create
        item = Item.create!(item_params)
        render json: {
          status: { item:, code: 200, message: 'Nemesis informa: Item do inventário cadastrado com sucesso.', status: :success }
        }
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      def item_params
        params.require(:item).permit(:description,
                                     :score)
      end
    end
  end
end
