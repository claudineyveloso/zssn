# frozen_string_literal: true

module Api
  module V1
    # InventáriosController is responsible for handling actions related to the user's item inventory,
    # In this controller we will only have the create and destroy method.
    class InventoriesController < ApplicationController
      def index
        inventories = Inventory.includes(:user)
        render json: inventories, each_serializer: InventorySerializer
      end

      def create
        User.find(params[:user_id])
        inventory = Inventory.create!(inventory_params)
        render json: {
          data: { inventory:, code: 201, message: 'Nemesis informa: Inventário cadastrado com sucesso.', status: :success }
        }
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      private

      def inventory_params
        params.require(:inventory).permit(:user_id)
      end
    end
  end
end
