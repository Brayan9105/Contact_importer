require 'rails_helper'

RSpec.describe "Api::V1::Book", type: :request do
  let(:user){ create(:user) }
  let(:token){ AuthenticationTokenService.encode(user.id) }

  describe 'POST /api/v1/books' do

    let!(:valid_params) do
      { book: {
          file: Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "csv_file.csv"), 'text/csv'),
          column_name: 1, column_dob: 2, column_phone: 3,
          column_address: 4, column_credit_card: 5, column_email: 6
      } }
    end

    subject { post '/api/v1/books', params: valid_params, headers: { 'Authorization' => "Bearer #{token}" } }

    it 'returns status code created' do
      subject
      expect(response).to have_http_status(:created)
    end
  end

  describe 'POST api/v1/books/:id/contacts/import' do
    let(:book){ create(:book, :valid_file) }
    subject{ post "/api/v1/books/#{book.id}/contacts/import", headers: { 'Authorization' => "Bearer #{token}" } }

    it 'return a status code ok' do
      subject
      expect(response).to have_http_status(:ok)
    end
  end
end
