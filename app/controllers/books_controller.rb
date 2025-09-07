class BooksController < ApplicationController
  def index
    @book_search_form = BookSearchForm.new(book_search_form_params)
    @books = @book_search_form.books
  end

  def show
    @book = Book.find(params[:book_id])
  end

  private

  def book_search_form_params
    params.fetch(:book_search_form, {}).permit(:query)
  end
end
