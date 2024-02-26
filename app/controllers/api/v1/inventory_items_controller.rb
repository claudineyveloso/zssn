# frozen_string_literal: true

module Api
  module V1
    # class InventoryItemsController
    class InventoryItemsController < ApplicationController
      before_action :set_inventory, only: [:destroy]

      def index
        inventory_items = InventoryItem.includes(:item)
        render json: { status: :ok, data: { inventory_items: ActiveModel::Serializer::CollectionSerializer.new(inventory_items, each_serializer: InventoryItemSerializer) } }
      end

      def create
        inventory = Inventory.find_by(id: params[:inventory_id])
        if inventory.nil?
          return render json: {
            data: {
              user:
            },
            message: 'Inventário não encontrado  !'
          }
        end

        user = User.infected?(inventory.user_id)
        if user.present?
          return render json: {
            data: {
              user:
            },
            message: 'Usuário infectado! Lamentamos informar que, devido à sua condição de saúde, você não pode criar um novo item de inventário no momento!'
          }
        end
        item = Item.find_by(id: inventory_item_params[:item_id])
        unless item
          render json: { error: 'Item não encontrado!' }, status: :not_found
          return
        end
        check_item = InventoryItem.includes(:inventory)
                                  .find_by(inventory: { id: params[:user_id].to_i }, item_id: item.id)
        if check_item.present?
          sum_quantity = check_item.quantity + params[:quantity]
          inventory_item = InventoryItem.where(
            inventory_id: params[:inventory_id].to_i,
            item: params[:item_id]
          ).update(quantity: sum_quantity)
          message = 'Quantidade do item atualizada com sucesso no inventário.'
        else
          inventory_item = InventoryItem.create!(inventory_item_params)
          message = 'Item cadastrado com sucesso no inventário.'
        end
        render json: {
          data: {
            inventory_item: ActiveModelSerializers::SerializableResource.new(inventory_item, serializer: InventoryItemSerializer),
            code: 201,
            message: "#{message}",
            status: :success
          }
        }
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      def destroy
        inventory = Inventory.find_by(id: params[:inventory_id])
        if inventory.nil?
          return render json: {
            data: {
              user:
            },
            message: 'Inventário não encontrado  !'
          }
        end

        user = User.infected(inventory.user_id)
        if user.present?
          return render json: {
            data: {
              user:
            },
            message: 'Usuário infectado! Lamentamos informar que, devido à sua condição de saúde, você não pode deletar item de inventário no momento!'
          }
        end
        inventory_item = InventoryItem.find(params[:id])
        inventory_item.destroy
        render json: { message: 'Item do inventário excluído com sucesso!' }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'ID não foi encontrado.' }, status: :not_found
      end

      def items_quantity_average
        render json: InventoryItem.average_quantity_per_user
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
