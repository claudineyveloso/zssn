# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/trades', type: :request do
  path '/api/v1/trades/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    patch('update trade') do
      tags 'InventoryItems'
      consumes 'application/json'
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          giver_id: { type: :integer },
          giver_items: { type: :array },
          receiver_id: { type: :integer },
          receiver_items: { type: :array }
        },
        required: %w[giver_id giver_items receiver_id receiver_items]
      }

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update trade') do
      tags 'InventoryItems'
      consumes 'application/json'
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          giver_id: { type: :integer },
          giver_items: { type: :array },
          receiver_id: { type: :integer },
          receiver_items: { type: :array }
        },
        required: %w[giver_id giver_items receiver_id receiver_items]
      }

      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
