# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/inventory_items', type: :request do
  path '/api/v1/inventory_items' do
    get('list inventory_items') do
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

    post('create inventory_item') do
      tags 'InventoryItems'
      consumes 'application/json'
      parameter name: :inventoty_item_params, in: :body, schema: {
        type: :object,
        properties: {
          inventory_id: { type: :integer },
          item_id: { type: :integer },
          quantity: { type: :integer }
        },
        required: %w[inventory_id item_id quantity]
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

  path '/api/v1/inventory/{inventory_id}/inventory_item/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'inventory_id', in: :path, type: :string, description: 'inventory_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    delete('delete inventory_item') do
      response(200, 'successful') do
        let(:inventory_id) { '123' }
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

  path '/api/v1/items_quantity_average' do
    get('items_quantity_average inventory_item') do
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
end
