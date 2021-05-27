module Api
  module V1
    class BooksController < ApiController
      before_action :authenticate_user

      def create
        book = current_user.books.create!(book_params)
        render_response(book, serializer: Api::V1::Books::ShowSerializer, status: :created)
      end

      def import_contacts
        ImportContactJob.perform_later(params[:book_id], current_user)
        render json: { status: 'Processing'}, status: :ok
      end

      private

      def book_params
        params.require(:book).permit(:file, :column_name, :column_dob, :column_phone,
          :column_address, :column_credit_card, :column_email)
      end
    end
  end
end
