class BooksController < ApplicationController
  before_action :set_book, only: [:show]
  before_action :set_ownership, only: [:show]
  before_action :set_interest, only: [:show]
  before_action :set_rating, only: [:show]

  def index
    @book_search_form = BookSearchForm.new(book_search_form_params)
    @books = @book_search_form.call
                              .preload(:ownerships, :interests)
                              .with_attached_image
                              .default_order
                              .page(params[:page])
  end

  def show
    @rating_form = RatingForm.build_from_rating(@rating)
    @comment = current_user.comments.build
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_ownership
    @ownership = current_user.ownerships.find_by(book_id: params[:id])
  end

  def set_interest
    @interest = current_user.interests.find_by(book_id: params[:id])
  end

  def set_rating
    return unless @ownership

    @rating = @ownership.rating
  end

  def book_search_form_params
    params.fetch(:book_search_form, {}).permit(:query)
  end
end
