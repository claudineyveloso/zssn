# frozen_string_literal: true

module Api
  module V1
    # UsersController is responsible for handling user-related actions,
    # such as creating, updating, and deleting users.
    class UsersController < ApplicationController
      before_action :set_user, only: %i[current_location show update destroy]

      # Public: Display a list of all users.
      # GET /api/v1/users
      # Returns an JSON displaying all users.
      def index
        users = User.all.order(name: :asc)
        render json: {
          meta: { infecteds: User.percentual_infecteds(true), no_infecteds: User.percentual_infecteds(false) },
          status: {
            data: { user: users }
          }
        }, status: :ok
      end

      # Public: Display details of a specific user.
      # GET /api/v1/users/2:id
      # id - The unique identifier of the user.
      # Returns an JSON displaying specified user.
      def show
        if @user
          render json: @user, each_serializer: UserSerializer
        else
          render json: { code: 404,
                         errors: @user.errors.full_messages,
                         message: 'Usuário não cadastrado no ZSSN.',
                         status: :not_found }
        end
      end

      # Public: Render a form for creating a new user.
      # GET /users/new
      # Returns an JSON  with new user  created.
      def new; end

      # Public: Create a new user.
      # POST /users
      # user_params - Strong parameters for creating a user, typically
      #               including :name, :email, :gender, :latitude, :longitude, :infected, :contamination_notification.
      # Returns a redirection to the created user's page or an error message.
      # Returns an JSON  with new user  created.
      def create
        user = User.create!(user_params)
        if user
          render json: {
            status: { code: 200, message: 'Usuário cadastrado com sucesso.', status: :success }
          }
        else
          render json: {
            status: { code: 500,
                      errors: user.errors.full_messages,
                      message: 'Ocorreu um erro para cadastrar um usuário.',
                      status: :error }
          }
        end
      end

      # Public: Render a form for editing a specific user.
      # GET /api/v1/users/:id/edit
      # id - The unique identifier of the user.
      # Returns an HTML page with a form for editing the specified user.
      def edit; end

      # Public: Update a specific user.
      # PATCH/PUT /api/v1/users/:id
      # id          - The unique identifier of the user.
      # user_params - Strong parameters for updating a user, typically
      #               including :name, :email, :gender, :latitude, :longitude, :infected, :contamination_notification.
      # Returns a redirection to the updated user's page or an error message.
      def update
        if @user
          @user.update(user_params)
          render json: {
            status: { code: 200, message: 'Dados do usuário alterado com sucesso.', status: :success }
          }
        else
          render json: { code: 404,
                         errors: @user.errors.full_messages,
                         message: 'Usuário não cadastrado no ZSSN.',
                         status: :not_found }
        end
      end

      # Public: Delete a specific user.
      # DELETE /api/v1/users/:id
      # id - The unique identifier of the user.
      # Returns a redirection to the list of users or an error message.
      def destroy
        if @user
          @user.destroy
          render json: { code: 200, message: 'Usuário apagado com sucesso.', status: :success }
        else
          render json: { code: 404,
                         errors: @user.errors.full_messages,
                         message: 'Usuário não cadastrado no ZSSN.',
                         status: :not_found }
        end
      end

      def current_location
        if @user
          @user.update(location_params)
          render json: { code: 200, message: 'Localização atualizada com sucesso.', status: :success }
        else
          render json: { code: 404, errors: @user.errors.full_messages, message: 'Usuário não cadastrado no ZSSN.', status: :not_found }
        end
      end

      private

      # Private: Set the @user instance variable based on the provided user ID.
      # This method is used as a `before_action` to ensure that the specified
      # user is loaded before certain actions (show, edit, update, destroy).
      # params[:id] - The unique identifier of the user.
      # Returns nothing. Sets the @user instance variable.
      def set_user
        @user = User.find_by(id: params[:id])
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
