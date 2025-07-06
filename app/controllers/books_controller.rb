class BooksController < ApplicationController
  def index
    @form = BookSearchForm.new(book_search_form_params)
    @books = @form.call.default_order.page(params[:page])
  end

  private

  def book_search_form_params
    params.fetch(:book_search_form, {}).permit(:query)
  end
end
