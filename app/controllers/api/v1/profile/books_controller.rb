module Api
  module V1
    module Profile
      class BooksController < ApiController
        before_action :authenticate_user

        def show
          render_response(book, serializer: Api::V1::Books::ShowSerializer, status: 200)
        end

        private

        def book
          book = Book.find(params[:id])
        end
      end
    end
  end
end
