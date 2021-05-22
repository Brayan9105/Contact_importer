module Api
  module V1
    class ProfilesController < ApiController
      def show
        render_collection(Book.all, root: 'books', serializer: Api::V1::Books::IndexSerializer)
      end

      private

      def books
        current_user.books
      end
    end
  end
end
