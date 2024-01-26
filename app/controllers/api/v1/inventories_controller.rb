# frozen_string_literal: true

module Api
  module V1
    class InventoriesController < ApplicationController
      def index
        inventories = Inventory.all
        render json: {
          data: { inventory: inventories }
        }, status: :ok
      end

      def create
        user = User.find(params[:user_id])
        item = Item.find(params[:item_id])
        quantidade = params[:quantidade]
        inventory = Inventory.create!(inventory_params)
        render json: {
          data: { user:, code: 200, message: 'Nemesis informa: Inventário cadastrado com sucesso.', status: :success }
        }
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      def destroy
        user = User.find(params[:user_id])
        item = Item.find(params[:item_id])
        inventory = Inventory.find_by(user_id: user, item_id: item)
        return render json: { "error": 'Nemesis informa: ID do item do inventário não encontrado!', "status": 'not_found' } unless inventory

        inventory.destroy
        render json: { code: 200, message: 'Item do inventário apagado com sucesso.', status: :success }
      end

      private

      def find_user
        User.find_by(id: params[:user_id])
      end

      def find_item
        Item.find_by(id: params[:item_id])
      end

      def inventory_params
        params.require(:inventory).permit(:user_id, items: %i[id description score quantity])
      end
    end
  end
end
