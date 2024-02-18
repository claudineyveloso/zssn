# frozen_string_literal: true

module Api
  module V1
    # class InventoryItemsController
    class InventoryItemsController < ApplicationController
      before_action :set_inventory

      def index
        inventory_items = InventoryItem.includes(:item)
        render json: { status: :ok, data: { inventory_items: ActiveModel::Serializer::CollectionSerializer.new(inventory_items, each_serializer: InventoryItemSerializer) } }

      end

      def create
        user = User.infected(params[:user_id])
        if user
          return render json: {
            data: {
              user:
            },
            message: 'Nemesis informa: Usuário infectado! Lamentamos informar que, devido à sua condição de saúde, você não pode criar um novo item de inventário no momento!'
          }
        end
        item = Item.find_by(id: inventory_item_params[:item_id])
        unless item
          render json: { error: 'Nemesis informa: Item não encontrado!' }, status: :not_found
          return
        end
        inventory_item = InventoryItem.create!(inventory_item_params)
        render json: {
          data: { inventory_item:, serializer: InventoryItemSerializer, code: 201, message: 'Nemesis informa: Item cadastrado com sucesso no inventário.', status: :success }
        }
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      def destroy
        user = User.infected(params[:user_id])
        if user
          return render json: {
            data: {
              user:
            },
            message: 'Nemesis informa: Usuário infectado! Lamentamos informar que, devido à sua condição de saúde, você não pode deletar item de inventário no momento!'
          }
        end
        inventory_item = InventoryItem.find(params[:id])
        inventory_item.destroy
        render json: { message: 'Nemesis informa: Item do inventário excluído com sucesso!' }
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: 'ID não foi encontrado.' }, status: :not_found
      end

      private

      def set_inventory
        @inventory = Inventory.find(params[:inventory_id])
      end

      # Only allow a trusted parameter "white list" through.
      def inventory_item_params
        params.require(:inventory_item).permit(:inventory_id, :item_id, :quantity)
      end
    end
  end
end
