module Api
  module V1
    class InventoryItemsController < ApplicationController
      def index
        inventory_items = InventoryItem.all
            render json: {
              status: :ok,
              data: { inventory_items: inventory_items }
            }
      end

      def show
      end

      def create
        inventory_item = InventoryItem.create!(inventory_item_params)
        render json: {
          data: { inventory_item:, code: 201, message: 'Nemesis informa: Item do inventário cadastrado com sucesso.', status: :success }
        }
      rescue ActiveRecord::RecordInvalid => e
          render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      private
      def set_inventory_item
        @inventory_item = InventoryItem.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def inventory_item_params
        params.require(:inventory_item).permit(:inventory_id, :item_id, :quantity)
      end


    end
  end
end
