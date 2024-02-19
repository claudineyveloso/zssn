# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  path '/api/v1/users' do
    post 'Create a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          age: { type: :integer },
          gender: { type: :string },
          latitude: { type: :string },
          longitude: { type: :string }
        },
        required: %w[name age gender latitude longitude]
      }

      response '201', 'user created' do
        let(:user) { { name: 'Claudiney Veloso', age: 55, gender: 'Masculino', latitude: '-19.92337069418504', longitude: '-43.942577690286285' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'invalid' } }
        run_test!
      end
    end

    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'user found' do
        let(:id) { User.create(name: 'Talita Melo', age: 40, gender: 'Feminino', latitude: '-23.5643034964438', longitude: '-46.65245026264863', infected: true, contamination_notification: 3).id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    path '/api/v1/infected' do
      get 'Returns the percentage of infected users' do
        tags 'Infected'
        produces 'application/json'

        response '200', 'Returns the percentage of infected users' do
          schema type: :object,
                 properties: {
                   data: {
                     type: :object,
                     properties: {
                       percentage: { type: :string },
                       users: {
                         type: :array,
                         items: {
                           type: :object,
                           properties: {
                             name: { type: :string },
                             age: { type: :integer },
                             gender: { type: :string },
                             latitude: { type: :string },
                             longitude: { type: :string },
                             infected: { type: :boolean },
                             contamination_notification: { type: :integer }
                           },
                           required: %w[name age gender latitude longitude infected contamination_notification]
                         }
                       }
                     },
                     required: %w[percentage users]
                   }
                 }
          run_test!
        end
      end
    end
  end
end
