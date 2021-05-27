require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /api/v1/authenticate' do
    let(:user) { create(:user) }

    it 'authenticates the client' do
      post '/api/v1/authenticate', params: { email: user.email, password: user.password }

      expect(response).to have_http_status(:created)
      expect(AuthenticationTokenService.decode(response_body['token'])).to eq(user.id)
    end

    xit 'returns error when email is missing' do
      post '/api/v1/authenticate', params: { password: user.password }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: email'
      })
    end

    xit 'returns error when password is missing' do
      post '/api/v1/authenticate', params: { email: 'test@mail.com' }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response_body).to eq({
        'error' => 'param is missing or the value is empty: password'
      })
    end

    it 'returns error when password is incorrect' do
      post '/api/v1/authenticate', params: { email: user.email, password: 'badpassword' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
