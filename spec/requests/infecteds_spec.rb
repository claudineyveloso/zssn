# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Infecteds API', type: :request do
  path '/api/v1/infecteds' do
    post 'Creates a new infected user record' do
      tags 'Infecteds'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user_id_reported, in: :body, schema: {
        type: :object,
        properties: {
          user_id_reported: { type: :integer },
          user_id_notified: { type: :integer }
        },
        required: %w[user_id_reported user_id_notified]
      }

      response '200', 'Infected user successfully registered' do
        let(:user_id_reported) { create(:user).id }
        let(:user_id_notified) { create(:user).id }

        run_test!
      end

      response '422', 'Validation error' do
        let(:user_id_reported) { nil }
        let(:user_id_notified) { nil }

        run_test!
      end
    end
  end
end
