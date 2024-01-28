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
        item = Item.find(params[:item_id])
        quantidade = params[:quantidade]
        inventory = Inventory.create!(inventory_params)
        render json: {
          data: { inventory:, code: 200, message: 'Nemesis informa: Item do inventário cadastrado com sucesso.', status: :success }
        }
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      def destroy
        user = User.find(params[:user_id])
        item = Item.find(params[:item_id])
        inventory = Inventory.find_by(user_id: user, item_id: item)
        return render json: { "error": 'Nemesis informa: ID do usuário ou do item do inventário não encontrado!', "status": 'not_found' } unless inventory

        inventory.destroy
        render json: { code: 200, message: 'Item do inventário apagado com sucesso.', status: :success }
      end

      def item_exchange
        requester = fetch_users(params[:user_id]) # User requesting the exchange
        receiver = fetch_users(params[:user_receiver_id])

        unless requester || requester.infected
          return render json: { "error": "Nemesis informa: Usuário #{requester.name} está infectado, os itens do inventário estão inacessíveis!",
                                "status": 'not_found' }
        end
        unless receiver || receiver.infected
          return render json: { "error": "Nemesis informa: Usuário #{receiver.name} está infectado, os itens do inventário estão inacessíveis!",
                                "status": 'not_found' }
        end

        offered_item_ids = params[:offered_item_ids]
        requested_item_ids = params[:requested_item_ids]
        offered_item_total = Item.where('id IN (:offered_item_ids)', offered_item_ids:).sum(:score)
        requested_item_total = Item.where('id IN (:requested_item_ids)', requested_item_ids:).sum(:score)

        unless offered_item_total == requested_item_total
          return render json: { data: { total_do_item_oferecido: offered_item_total, total_do_item_solicitado: requested_item_total }, "error": 'Nemesis informa: Total de pontos dos intens trocados são diferentes!',
                                status: :exchange_failed }
        end

        fetch_exchange(requester.id, offered_item_ids, 'subtract')
        fetch_exchange(receiver.id, requested_item_ids, 'add')
        render json: { "error": 'Nemesis informa: Items do inventário foram trocados com sucesso!', status: :success }
      end

      private

      def fetch_users(id)
        User.find_by(id:)
      end

      def find_user
        User.find_by(id: params[:user_id])
      end

      def find_item
        Item.find_by(id: params[:item_id])
      end

      def fetch_exchange(user_id, item_ids, type)
        binding.break
        item_ids.each do |item|
          inventory = Inventory.find_by(user_id:, item_id: item)
          if type == 'subtract'
            inventory.update_columns(quantity: inventory.quantity -= 1)
          else
            inventory.update_columns(quantity: inventory.quantity += 1)
          end
        end
      end

      def inventory_params
        params.require(:inventory).permit(:user_id, :item_id, :quantity)
      end
    end
  end
end
