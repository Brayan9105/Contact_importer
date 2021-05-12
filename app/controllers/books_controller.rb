class BooksController < ApplicationController
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

  private

  def book_params
    params.require(:book).permit(:file, :column_name, :column_dob, :column_phone,
      :column_address, :column_credit_card, :column_franchise, :column_email)
  end
end
