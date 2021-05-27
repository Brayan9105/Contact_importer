module Api
  module V1
    class ProfilesController < ApiController
      before_action :authenticate_user

      def show
        render_collection(books, root: 'books', serializer: Api::V1::Books::IndexSerializer)
      end

      private

      def books
        current_user.books
      end
    end
  end
end
