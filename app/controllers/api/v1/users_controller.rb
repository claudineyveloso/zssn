# frozen_string_literal: true

module Api
  module V1
    # UsersController is responsible for handling user-related actions,
    # such as creating, updating, and deleting users.
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      # Public: Display a list of all users.
      # GET /users
      # Returns an JSON displaying all users.
      def index
        # binding.break
        render json: 'GET users'
      end

      # Public: Display details of a specific user.
      # GET /users/:id
      # id - The unique identifier of the user.
      # Returns an JSON displaying specified user.
      def show; end

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
      def create; end

      # Public: Render a form for editing a specific user.
      # GET /users/:id/edit
      # id - The unique identifier of the user.
      # Returns an HTML page with a form for editing the specified user.
      def edit; end

      # Public: Update a specific user.
      # PATCH/PUT /users/:id
      # id          - The unique identifier of the user.
      # user_params - Strong parameters for updating a user, typically
      #               including :name, :email, :gender, :latitude, :longitude, :infected, :contamination_notification.
      # Returns a redirection to the updated user's page or an error message.
      def update; end

      # Public: Delete a specific user.
      # DELETE /users/:id
      # id - The unique identifier of the user.
      # Returns a redirection to the list of users or an error message.
      def destroy; end

      private

      # Private: Set the @user instance variable based on the provided user ID.
      # This method is used as a `before_action` to ensure that the specified
      # user is loaded before certain actions (show, edit, update, destroy).
      # params[:id] - The unique identifier of the user.
      # Returns nothing. Sets the @user instance variable.
      def set_user
        @user = User.find(params[:id])
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
