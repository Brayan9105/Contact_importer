require 'rails_helper'

RSpec.describe "Books", type: :request do
  include_context "Api::V1 Sign in user"

  describe 'POST /api/v1/books' do
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

    subject { post '/api/v1/books', params: valid_params }

    it 'returns status code created' do
      subject
      expect(response).to have_http_status(:created)
    end
  end
end
