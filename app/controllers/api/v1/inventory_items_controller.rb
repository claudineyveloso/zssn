module Api
  module V1
    class InventoryItemsController < ApplicationController

      before_action :set_user
      before_action :set_inventory
      before_action :set_inventory_item, only: [:destroy]

      def index
        inventory_items = InventoryItem.all
        render json: { status: :ok, data: { inventory_items: inventory_items } }
      end

      def show; end

      def create
        @inventory_item = @inventory.inventory_items.build(inventory_item_params)
        #inventory_item = InventoryItem.create!(inventory_item_params)
        render json: {
          data: { inventory_item:, code: 201, message: 'Nemesis informa: Item do inventário cadastrado com sucesso.', status: :success }
        } if @inventory_item.save
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      def destroy
        @inventory_item.destroy
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def set_inventory
        @inventory = @user.inventory
      end

      def set_inventory_item
        @inventory_item = @inventory.inventory_items.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def inventory_item_params
        params.require(:inventory_item).permit(:inventory_id, :item_id, :quantity)
      end
    end
  end
end
