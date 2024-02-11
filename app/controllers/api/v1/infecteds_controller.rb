# frozen_string_literal: true

module Api
  module V1
    # InfectedsController is responsible for handling actions related to infected user notification.
    class InfectedsController < ApplicationController
      def index; end

      def create
        was_reported = Infected.find_by(user_id_reported: params[:user_id_reported], user_id_notified: params[:user_id_notified]).present? ? true : false
        return render json: { user_id: params[:user_id_notified], message: 'Nemesis informa: Contaminação deste usuário já foi reportada.' } if was_reported

        infected = Infected.create!(infected_params)
        if infected
          render json: {
            status: { code: 200, message: 'Nemesis informa: Usuário infectado cadastrado com sucesso.', status: :success }
          }
          ContaminationService.new(params[:user_id_notified]).update_contamination
        else
          render json: {
            status: { code: 500,
                      errors: infected.errors.full_messages,
                      message: 'Nemesis informa: Ocorreu um erro para cadastrar um usuário infectado.',
                      status: :error }
          }
        end
      end

      def check_infected
        result = Infected.find_by(user_id_reported: params[:user_id_reported], user_id_notified: params[:user_id_notified]).present?
        render json: { result: }
      end

      def infected_params
        params.require(:infected).permit(:user_id_reported,
                                         :user_id_notified)
      end
    end
  end
end
