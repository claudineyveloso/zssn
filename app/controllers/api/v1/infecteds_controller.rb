# frozen_string_literal: true

module Api
  module V1
    class InfectedsController < ApplicationController
      def index; end

      def create
        infected = Infected.create!(infected_params)
        if infected
          render json: {
            status: { code: 200, message: 'Usuário infectado cadastrado com sucesso.', status: :success }
          }
        else
          render json: {
            status: { code: 500,
                      errors: infected.errors.full_messages,
                      message: 'Ocorreu um erro para cadastrar um usuário infectado.',
                      status: :error }
          }
        end
      end

      def infected_params
        params.require(:user).permit(:user_id_reported,
                                     :user_id_notified)
      end
    end
  end
end
