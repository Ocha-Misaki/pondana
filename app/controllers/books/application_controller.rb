class Books::ApplicationController < ApplicationController
  before_action :set_book

  def set_book
    @book = Book.find(params[:book_id])
  end
end
