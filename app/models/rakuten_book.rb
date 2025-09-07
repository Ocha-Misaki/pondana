class RakutenBook
  include ActiveModel::Attributes
  # include ActiveRecord::Store

  attribute :resource
  # store_accessor :resource, :title

  def title
    case @resource
    when Hash
      @resource['title']
    when Book
      @resource.title
    end
  end

  class << self
    def create_book(rakuten_id)
      book = RakutenWebService::Books::Total.search(keyword: rakuten_id)

      book = find_or_initialize_by(store_url: item['params']['itemUrl'])
      return if book.persisted?

      book.title = item['params']['title']
      book.author = item['params']['author']
      book.description = item['params']['itemCaption']

      if item['params']['largeImageUrl'].present?
        book.image.attach(io: OpenURI.open_uri(item['params']['largeImageUrl']), filename: 'book_image.jpg', content_type: 'image/jpeg')
      end

      book.save!
      book
    end
  end
end
