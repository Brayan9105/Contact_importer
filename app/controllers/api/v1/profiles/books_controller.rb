module Api
  module V1
    module Profiles
      class BooksController < ApiController
        def show
          # contacts = book.contacts
          # invalid_contacts = book.invalid_contacts
          render_response(book, serializer: Api::V1::Books::ShowSerializer, status: 200)
          # render json: { data: 'success' } status: 200
        end

        private

        def book
          book = Book.find(params[:id])
          # book.includes(:contacts)
        end
      end
    end
  end
end
