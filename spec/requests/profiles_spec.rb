require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let!(:current_user){ create(:user) }
  before{ sign_in current_user }

  describe 'Get /profile' do
    it 'returns the expect variables' do
      get '/profile'
      expect(assigns(:user)).not_to be_nil
      expect(assigns(:books)).not_to be_nil
    end
  end
end
