require 'rails_helper'

RSpec.describe 'Api::V1:Profile::Book', type: :request do
  let(:user){ create(:user) }
  let(:book){ create(:book, :valid_file, user: user) }
  let(:token){ AuthenticationTokenService.encode(user.id) }

  describe 'GET /api/v1/profile/book/:id' do
    it 'returns the current_user book list' do
      get "/api/v1/profile/book/#{book.id}", headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:ok)
    end
  end
end
