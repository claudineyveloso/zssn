# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/inventories', type: :request do
  path '/api/v1/inventories' do
    get('list inventories') do
      response(200, 'successful') do
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

    post('create inventory') do
      tags 'Inventory'
      consumes 'application/json'
      parameter name: :inventory_params, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer }
        },
        required: %w[user_id]
      }

      response(200, 'successful') do
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

  path '/api/v1/inventories/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show inventory') do
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
