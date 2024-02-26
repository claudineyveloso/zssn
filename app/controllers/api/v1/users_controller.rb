# frozen_string_literal: true

module Api
  module V1
    # UsersController is responsible for handling user-related actions,
    # such as creating, updating, and deleting users.
    class UsersController < ApplicationController
      # Public: Display a list of all users.
      # GET /api/v1/users
      # Returns a JSON displaying a given user.
      def show
        user = find_user
        return render json: { error: 'ID do usuário não encontrado!', status: :not_found, code: 404 } unless user

        render json: { data: user, code: 200, message: "Dados do usuário - #{user.name}.", status: :success }
      end

      # Public: Create a new user.
      # POST /users
      # user_params - Strong parameters for creating a user, typically
      #               including :name, :age, :gender, :latitude, :longitude, :infected, :contamination_notification.
      # Returns an JSON  with new user  created.
      def create
        user = UserService.create_user_with_inventory(user_params)
        render json: {
          data: { user:, code: 201, message: 'Usuário cadastrado com sucesso.', status: :success }
        }
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      # Public: List of users infected.
      # POST /users
      # Returns an JSON with one list of users infected.
      def infected
        render json: User.percentual_infecteds(true)
      end

      # Public: List of users uinfected.
      # POST /users
      # Returns an JSON with one list of users uninfected.
      def uninfected
        render json: User.percentual_infecteds(false)
      end

      # Public: List of users with lost scores.
      # POST /users
      # Returns an JSON with one list of users with lost scores.
      def lost_score
        render json: User.lost_score
      end

      # Public: Update the location a specific user..
      # PUT /api/v1/users/:id/current_location
      # id - The unique identifier of the user.
      # Returns a user with their updated location
      def current_location
        user = find_user
        return render json: { error: 'ID do usuário não encontrado!', status: :not_found } unless user

        user.update(location_params)
        render json: { data: {
                         id: user.id,
                         name: user.name,
                         age: user.age,
                         latitude: user.latitude,
                         longitude: user.longitude,
                         infected: user.infected,
                         contamination_notification: user.contamination_notification,
                         created_at: user.created_at,
                         updated_at: user.updated_at
                       },
                       code: 200,
                       message: 'Localização atualizada com sucesso.',
                       status: :success }
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.messages, status: :unprocessable_entity }
      end

      private

      # Private: Set the method  based on the provided user ID.
      # user is loaded.
      # params[:id] - The unique identifier of the user.
      def find_user
        User.find_by(id: params[:id])
      end

      def location_params
        params.require(:user).permit(:latitude, :longitude)
      end

      # Private: Defines the permitted parameters for user creation and update.
      # This method is commonly used in the create and update actions to whitelist
      # the parameters that can be mass-assigned to a User model.
      # Returns a Hash with the permitted user parameters.
      def user_params
        params.require(:user).permit(:name,
                                     :age,
                                     :gender,
                                     :latitude,
                                     :longitude,
                                     :infected,
                                     :contamination_notification)
      end
    end
  end
end
