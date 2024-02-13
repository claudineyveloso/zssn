# frozen_string_literal: true

module Api
  module V1
    # InventáriosController is responsible for handling actions related to the user's item inventory,
    # In this controller we will only have the create and destroy method.
    class InventoriesController < ApplicationController
      def index
        user = User.find(params[:user_id])
        inventories = Inventory.where(user_id: user.id).map { |u| u.as_json.merge(user:) }

        render json: {
          data: { inventory: inventories }
        }, status: :ok
      end

      def create
        user = User.find(params[:user_id])
        inventory = Inventory.create!(inventory_params)
        render json: {
          data: { inventory:, code: 201, message: 'Nemesis informa: Inventário cadastrado com sucesso.', status: :success }
        }
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      def inventory_items
        user = User.find(params[:user_id])
        inventory = user.inventory
        render json: { data: {
          id: user.id,
          name: user.name,
          gender: user.gender,
          items: inventory.inventory_items

        },
          code: 200,
          message: "Nemesis informa: Items do inventário do usuário #{user.name}.",
          status: :success,
        }

      end

      private

      def fetch_users(id)
        User.find_by(id:)
      end

      def find_user
        User.find_by(id: params[:user_id])
      end

      def inventory_params
        params.require(:inventory).permit(:user_id)
      end
    end
  end
end
