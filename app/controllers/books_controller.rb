class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to profile_book_path(@book)
    else
      render :new, alert: 'Some erros avoid to create the resource'
    end
  end

  def import_contacts
    ImportContactJob.perform_later(params[:book_id], current_user)

    respond_to do |format|
      format.js
    end
  end

  private

  def book_params
    params.require(:book).permit(:file, :column_name, :column_dob, :column_phone,
      :column_address, :column_credit_card, :column_email)
  end
end
