require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  let!(:current_user){ create(:user) }
  before{ sign_in current_user }

  describe 'Get /' do
    it 'returns the root page' do
      get '/'
      expect(response).to render_template(:index)
    end
  end
end
