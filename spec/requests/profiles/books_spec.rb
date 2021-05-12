require 'rails_helper'

RSpec.describe 'Profiles::Books', type: :request do
  let!(:current_user){ create(:user) }
  let!(:book){ create(:book, :valid_file, user: current_user) }
  let!(:book_id){ book.id }
  before{ sign_in current_user }

  describe 'GET /profile/books/:id' do
    it 'renders show' do
      get "/profile/books/#{book_id}"
      expect(response).to render_template(:show)
    end

    it 'returns the expect variables' do
      get "/profile/books/#{book_id}"
      expect(assigns(:book)).not_to be_nil
    end
  end
end
