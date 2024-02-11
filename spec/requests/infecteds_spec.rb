# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::InfectedsController, type: :request do
  describe '#check_infected' do
    # it 'returns true when Infected record is present' do
    #   # Suponha que você tenha um registro existente no banco de dados com os parâmetros fornecidos
    #   infected = Infected.create(user_id_reported: 1, user_id_notified: 2)

    #   # puts '################################################################'
    #   # puts infected.user_id_reported
    #   # puts '################################################################'

    #   # Simule a chamada do método no controlador
    #   get api_v1_check_infected_path, params: { user_id_reported: infected.user_id_reported, user_id_notified: infected.user_id_notified }
    #   puts '################################################################'
    #   puts response.body
    #   puts '################################################################'
    #   # Verifique se o resultado da lógica é verdadeiro
    #   expect(response.body).to eq({ result: true }.to_json)
    # end
  end

  # it 'returns false when Infected record is not present' do
  #   # Simule a chamada do método no controlador com parâmetros para os quais não há registro no banco de dados
  #   get api_v1_check_infected_path, params: { user_id_reported: 1, user_id_notified: 4 }

  #   # Verifique se o resultado da lógica é falso
  #   expect(response.body).to eq({ result: false }.to_json)
  # end

  describe 'POST #create' do
    let(:valid_params) { { user_id_reported: 1, user_id_notified: 2 } }

    context 'when user contamination was not reported before' do
      it 'creates a new Infected record and updates contamination' do
        # expect(Infected).to receive(:find_by).with(user_id_reported: 1, user_id_notified: 2).and_return(nil)
        # expect(Infected).to receive(:create!).with(valid_params).and_return(true)
        # expect_any_instance_of(ContaminationService).to receive(:update_contamination)

        # post api_v1_infecteds_path, params: valid_params

        # expect(response).to have_http_status(:success)
        # # puts '################################################################'
        # # puts response
        # # puts '################################################################'

        # expect(JSON.parse(response.body)['status']['code']).to eq(200)
      end
    end

    # context 'when user contamination was reported before' do
    #   it 'returns a JSON response indicating contamination already reported' do
    #     expect(Infected).to receive(:find_by).with(user_id_reported: 1, user_id_notified: 2).and_return(double('Infected'))

    #     post api_v1_infecteds_path, params: valid_params

    #     expect(response).to have_http_status(:success)
    #     expect(JSON.parse(response.body)['status']['code']).to eq(200)
    #     expect(JSON.parse(response.body)['message']).to include('Nemesis informa: Contaminação deste usuário já foi reportada.')
    #   end
    # end

    # context 'when an error occurs during Infected creation' do
    #   it 'returns a JSON response indicating an error' do
    #     expect(Infected).to receive(:find_by).with(user_id_reported: 1, user_id_notified: 2).and_return(nil)
    #     expect(Infected).to receive(:create!).with(valid_params).and_raise(ActiveRecord::RecordInvalid.new(Infected.new))

    #     post api_v1_infecteds_path, params: valid_params

    #     expect(response).to have_http_status(:error)
    #     expect(JSON.parse(response.body)['status']['code']).to eq(500)
    #     expect(JSON.parse(response.body)['status']['errors']).not_to be_empty
    #   end
    # end
  end
end
