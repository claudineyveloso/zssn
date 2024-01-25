# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'GET #index' do
    context 'when the user exists' do
      it 'returns a JSON with status code 200' do
        get api_v1_users_path
        expect(response).to have_http_status(200)
        expect(response).to have_http_status(:success)
      end
    end
    # context 'when the user does not exist' do
    #   it 'returns a JSON with status code 404 and an error message' do
    #     id_nao_existente = 999
    #     get api_v1_users_path(id_nao_existente)
    #     expect(response).to have_http_status(:not_found)
    #   end
    # end
  end
end
