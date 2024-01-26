# frozen_string_literal: true

module Api
  module V1
    class InventoriesController < ApplicationController
      def index
        inventory = Inventory.all
        render json: inventory
      end

      def show
        render json: @inventory
      end

      def create
        inventory = Inventory.create!(inventory_params)
        if inventory
          render json: {
            status: { code: 200, message: 'Nemesis informa: Inventário cadastrado com sucesso.', status: :success }
          }
        else
          render json: {
            status: { code: 500,
                      errors: user.errors.full_messages,
                      message: 'Nemesis informa: Ocorreu um erro para cadastrar item(s) no inventário do usuário.',
                      status: :error }
          }
        end
      end

      def update
        if @inventory.update(inventory_params)
          render json: @inventory
        else
          render json: @inventory.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @inventory.destroy
        head :no_content
      end

      private

      def set_inventory
        @inventory = Inventory.find(params[:id])
      end

      def inventory_params
        params.require(:inventory).permit(:user_id, items: %i[id description score total])
      end
    end
  end
end
