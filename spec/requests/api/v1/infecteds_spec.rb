require 'swagger_helper'

RSpec.describe 'api/v1/infecteds', type: :request do
  path '/api/v1/infecteds' do
    post('create infected') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :infected_params, in: :body, schema: {
        type: :object,
        properties: {
          user_id_reported: { type: :integer },
          user_id_notified: { type: :integer }
        },
        required: %w[user_id_reported user_id_notified]
      }

      response(201, 'successful') do
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

  path '/api/v1/check_infected' do
    get('check_infected infected') do
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
