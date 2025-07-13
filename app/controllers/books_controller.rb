class BooksController < ApplicationController
  before_action :set_book, only: [:show]
  before_action :set_having_book, only: [:show]
  before_action :set_interest, only: [:show]
  before_action :set_rating, only: [:show]

  def index
    @book_search_form = BookSearchForm.new(book_search_form_params)
    @books = @book_search_form.call
                              .preload(:having_books, :interests)
                              .with_attached_image
                              .default_order
                              .page(params[:page])
  end

  def show
    @rating_form = RatingForm.new.call(@having_book)
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_having_book
    @having_book = current_user.having_books.find_by(book_id: params[:id])
  end

  def set_interest
    @interest = current_user.interests.find_by(book_id: params[:id])
  end

  def set_rating
    return unless @having_book

    @rating = @having_book.rating
  end

  def book_search_form_params
    params.fetch(:book_search_form, {}).permit(:query)
  end
end
