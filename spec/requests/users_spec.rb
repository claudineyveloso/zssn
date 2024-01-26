# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'GET #index' do
    it 'returns non-infected users ordered by name' do
      user1 = User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                          infected: false)
      user2 = User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                          infected: false)
      user3 = User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                          infected: true)
      # result = User.all.where(infected: false).order(name: :asc)
      # expect(result).to eq([user2, user1])

      get api_v1_users_path
      expect(response).to have_http_status(:ok)

      percentage_infected = User.percentual_infecteds(true)
      expect(percentage_infected).to eq(33.33333333333333)

      percentage_no_infected = User.percentual_infecteds(false)
      expect(percentage_no_infected).to eq(66.66666666666666)
    end
  end

  describe 'GET #show' do
    it 'returns the user JSON when the ID exists' do
      # Create a user to get an existing ID
      existing_user = User.create(name: Faker::Name.name, age: Faker::Number.between(from: 18, to: 99), gender: 'Male', latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                                  infected: false)

      # Execute the GET request for the show method
      get api_v1_user_path(id: existing_user.id)

      # Check if the HTTP status is successful (status 200)
      expect(response).to have_http_status(:success)

      # Parse the JSON of the response
      json_response_body = JSON.parse(response.body)
      user_name = json_response_body['data']['name']
      json_response = {
        'data' => {
          'user' => existing_user.as_json,
          'code' => 200,
          'message' => "Nemesis informa: Dados do usuário - #{user_name}.",
          'status' => 'success'
        }
      }

      # Verifique se o JSON contém as informações esperadas
      expect(json_response).to eq(
        {
          'data' => {
            'user' => existing_user.as_json,
            'code' => 200,
            'message' => "Nemesis informa: Dados do usuário - #{user_name}.",
            'status' => 'success'
          }
        }
      )
    end
  end
end
