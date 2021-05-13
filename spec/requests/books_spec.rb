require 'rails_helper'

RSpec.describe "Books", type: :request do
  let!(:current_user){ create(:user) }
  before{ sign_in current_user }

  describe 'GET /books/new' do
    subject { get '/books/new' }

    it 'return status code 200' do
      subject
      expect(response).to have_http_status(200)
    end

    it 'assigns the expect variable' do
      subject
      expect(assigns(:book)).to_not be_nil
    end
  end

  describe 'POST /books' do
    let!(:valid_params) do
      {
        book: {
          file: Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "csv_file.csv"), 'text/csv'),
          column_name: 1,
          column_dob: 2,
          column_phone: 3,
          column_address: 4,
          column_credit_card: 5,
          column_email: 6
        }
      }
    end

    context 'when pass a valid params ' do
      subject { post '/books', params: valid_params }

      it 'returns status code 301' do
        subject
        expect(response).to have_http_status(:redirect)
      end

      it 'increse the Book.count' do
        expect{subject}.to change(Book, :count).by(1)
      end
    end

    context 'when pass a invalid params' do
      subject{ post '/books', params: { book: { column_name: 10 } } }

      it 'returns status code 200' do
        subject
        expect(response).to have_http_status(200)
      end

      it 'render a new template' do
        subject
        expect(response).to render_template(:new)
      end
    end
  end
end
