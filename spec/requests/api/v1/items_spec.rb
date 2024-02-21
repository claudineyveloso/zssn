require 'swagger_helper'

RSpec.describe 'api/v1/items', type: :request do
  path '/api/v1/items' do
    get('list items') do
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

    post('create item') do
      tags 'Items'
      consumes 'application/json'
      parameter name: :item_params, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          score: { type: :integer }
        },
        required: %w[description score]
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
end
