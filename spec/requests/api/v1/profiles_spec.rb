require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  describe 'GET /api/v1/profiles' do
    it 'returns the current_user book list' do
      get '/api/v1/profile'

      expect(response).to have_http_status(:ok)
    end
  end
end
