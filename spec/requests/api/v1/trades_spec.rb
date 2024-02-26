# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Trades', type: :request do
  path '/api/v1/trades' do
    post 'Creates a trade' do
      tags 'Trades'
      consumes 'application/json'
      parameter name: :trade, in: :body, schema: {
        type: :object,
        properties: {
          giver_id: { type: :integer },
          receiver_id: { type: :integer },
          giver_items: { type: :object },
          receiver_items: { type: :object }
        },
        required: %w[giver_id receiver_id giver_items receiver_items]
      }

      response '200', 'trade created' do
        let(:trade) { { giver_id: 1, receiver_id: 2, giver_items: { item1: 1 }, receiver_items: { item2: 2 } } }

        run_test! do
          expect(response).to have_http_status(200)
        end
      end

      response '422', 'invalid trade parameters' do
        let(:trade) { { giver_id: 1, receiver_id: 2 } }

        run_test! do
          expect(response).to have_http_status(422)
        end
      end
    end
  end
end
