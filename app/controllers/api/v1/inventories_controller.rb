# frozen_string_literal: true

module Api
  module V1
    class InventoriesController < ApplicationController
      def index
        inventory = Inventory.all
        render json: inventory
      end

      def show
        render json: @inventario
      end

      def create
        @inventario = Inventario.new(inventario_params)

        if @inventario.save
          render json: @inventario, status: :created
        else
          render json: @inventario.errors, status: :unprocessable_entity
        end
      end

      def update
        if @inventario.update(inventario_params)
          render json: @inventario
        else
          render json: @inventario.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @inventario.destroy
        head :no_content
      end

      private

      def set_inventario
        @inventario = Inventario.find(params[:id])
      end

      def inventario_params
        # params.require(:inventario).permit(:usuario_id, :data, itens: %i[comida agua medicamento municao])
        params.require(:inventario).permit(:usuario_id, :data, itens: [])
      end
    end
  end
end
