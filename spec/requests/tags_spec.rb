require 'rails_helper'

RSpec.describe 'Tags API' do
  let!(:member) { create(:member) }
  let!(:tags) { create_list(:tag, 20, member_id: member.id) }
  let(:member_id) { member.id }
  let(:id) { tags.first.id }

  describe 'GET /members/:member_id/tags' do
    before { get "/members/#{member_id}/tags", params: {} }

    context 'when member exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all member tags' do
        expect(json.size).to eq(20)
      end
    end

    context 'when member does not exist' do
      let(:member_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Member/)
      end
    end
  end

  describe 'GET /members/:member_id/tags/:id' do
    before { get "/members/#{member_id}/tags/#{id}", params: {} }

    context 'when member tag exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the tag' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when member tag does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tag/)
      end
    end
  end

  describe 'POST /members/:member_id/tags' do
    let(:valid_attributes) { { name: 'Angular Developer' } }

    context 'when request attributes are valid' do
      before do
        post "/members/#{member_id}/tags", params: valid_attributes
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/members/#{member_id}/tags", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /members/:member_id/tags/:id' do
    let(:valid_attributes) { { name: 'Designer' } }

    before do
      put "/members/#{member_id}/tags/#{id}", params: valid_attributes
    end

    context 'when tag exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the tag' do
        updated_tag = Tag.find(id)
        expect(updated_tag.name).to match(/Designer/)
      end
    end

    context 'when tag does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tag/)
      end
    end
  end

  describe 'DELETE /members/:id' do
    before { delete "/members/#{member_id}/tags/#{id}", params: {} }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end