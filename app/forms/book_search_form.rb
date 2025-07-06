class BookSearchForm < ApplicationForm
  attribute :query, :string

  def call
    return Book.all if query.blank?

    items = RakutenWebService::Books::Total.search(keyword: query)
    return Book.all if items.blank?

    Book.create_from_store(items.first(10))
  end
end
