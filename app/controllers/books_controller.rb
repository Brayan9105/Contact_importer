class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      # pending set route
      # redirecto_to
    else
      render :new, alert: 'Some erros avoid to create the resource'
    end
  end

  private

  def book_params
    params.require(:book).permit(:file)
  end
end
