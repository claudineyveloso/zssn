# frozen_string_literal: true

module Api
  module V1
    # ItemsController is responsible for handling item-related actions,
    # In this controller we will only have the create method.
    class ItemsController < ApplicationController
      before_action :set_item, only: %i[show update destroy]
      def index
        items = Item.all.order(description: :asc)
        # users = User.all.order(email: :asc)
        render json: items, status: 200, each_serializer: ItemSerializer
      end

      def create
        item = Item.create!(item_params)
        if item
          render json: {
            status: { code: 200, message: 'Item do inventário cadastrado com sucesso.', status: :success }
          }
        else
          render json: {
            status: { code: 500,
                      errors: @user.errors.full_messages,
                      message: 'Ocorreu um erro para cadastrar um Item do inventário.',
                      status: :error }
          }
        end
      end

      def item_params
        params.require(:user).permit(:description,
                                     :score)
      end
    end
  end
end
