# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Items API', type: :request do
  path '/api/v1/non_existent_route' do
    get 'Returns 404 when the route does not exist' do
      tags 'Non-existent Route'

      response '404', 'Route not found' do
        run_test!
      end
    end
  end

  path '/api/v1/items' do
    post 'Create a new inventory item' do
      tags 'Items'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :item, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          score: { type: :integer }
        },
        required: %w[description score]
      }

      response '201', 'Inventory item registered successfully' do
        let(:item) { { description: 'Água', score: 4 } }

        run_test!
      end

      response '422', 'Validation error' do
        let(:item) { { description: '', score: 1 } }

        run_test!
      end
    end
  end
end
