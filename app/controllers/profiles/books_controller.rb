class Profiles::BooksController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @book = Book.find(params[:id])
  end
end
