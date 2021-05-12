class ProfilesController < ApplicationController
  def show
    @user = current_user
    @books = @user.books
  end
end
