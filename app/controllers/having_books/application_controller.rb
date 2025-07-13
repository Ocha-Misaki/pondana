class HavingBooks::ApplicationController < ApplicationController
  before_action :set_having_book

  def set_having_book
    @having_book = current_user.having_books.find(params[:having_book_id])
  end
end
