class BookSearchForm < ApplicationForm
  attribute :query, :string

  def books
    return [] if query.blank?

    items = RakutenWebService::Books::Total.search(keyword: query)
    return [] if items.blank?

    items.first(10)
    # NOTE: 元々return falseだったが、返り値はActiveRecord::Relationである方が適切

    # FB
    # - ここの処理がActiveRecord::Relationを返したり、itemsを返したりしている時点で設計が破綻している
  end
end
