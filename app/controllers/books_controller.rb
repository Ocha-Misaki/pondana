class BooksController < ApplicationController
  def index
    @books = Book.default_order.page(params[:page])
  end
end
