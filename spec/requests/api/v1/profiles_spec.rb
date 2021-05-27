require 'rails_helper'

RSpec.describe 'Api::V1::Profiles', type: :request do
  let(:user){ create(:user) }
  let(:token){ AuthenticationTokenService.encode(user.id) }

  describe 'GET /api/v1/profile' do
    it 'returns the current_user book list' do
      get '/api/v1/profile', headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
    end
  end
end
