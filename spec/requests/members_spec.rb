require 'rails_helper'

RSpec.describe 'Members API', type: :request do
  # add members owner
  let!(:members) { create_list(:member, 10) }
  let(:member_id) { members.first.id }

  describe 'GET /members' do
    # update request
    before { get '/members', params: {} }

    it 'returns members' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /members/:id' do
    before { get "/members/#{member_id}", params: {} }

    context 'when the record exists' do
      it 'returns the member' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(member_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:member_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Member/)
      end
    end
  end

  describe 'POST /members' do
    let(:valid_attributes) {
      { first_name: 'Johnie', last_name: 'Walker', member_type: 'contractor', duration: 10 }
    }

    context 'when request is valid' do
      before { post '/members', params: valid_attributes }

      it 'creates a member' do
        expect(json['first_name']).to eq('Johnie')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { first_name: nil } }
      before { post '/members', params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: First name can't be blank, Last name can't be blank, Member type can't be blank/)
      end
    end
  end

  describe 'PUT /members/:id' do
    let(:valid_attributes) { { first_name: 'Paul' } }

    context 'when the record exists' do
      before { put "/members/#{member_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /members/:id' do
    before { delete "/members/#{member_id}", params: {} }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end