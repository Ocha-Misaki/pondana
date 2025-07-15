class Book < ApplicationRecord
  belongs_to :genre
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end
  has_many :ownerships, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :owners, through: :ownerships, source: :user
  has_many :interesting_users, through: :interests, source: :user
  has_many :ratings, through: :ownerships

  validates :title, presence: true
  validates :author, presence: true
  validates :description, presence: true
  validates :store_url, presence: true, uniqueness: { scope: :title }
  validates :image, presence: true, blob: { content_type: ["image/png", "image/jpg", "image/jpeg"], size_range: 1..(5.megabytes) }

  scope :default_order, -> { order(created_at: :desc) }

  class << self
    def create_from_store(items)
      books = items.map do |item|
        book = find_or_initialize_by(store_url: item['itemUrl'])
        book.title = item['title']
        book.author = item['author']
        book.description = item['itemCaption']
        book.genre = Genre.search_and_create_by!(item['booksGenreId'])

        if book.image.blank? && item['largeImageUrl'].present?
          book.image.attach(io: OpenURI.open_uri(item['largeImageUrl']), filename: 'book_image.jpg', content_type: 'image/jpeg')
        end

        book.save
        book
      end
      Book.where(id: books.map(&:id))
    end
  end

  def average_rating
    return false if ratings.empty?

    total_readability = ratings.sum(:readability)
    total_recommendation = ratings.sum(:recommendation)
    total_helpfulness = ratings.sum(:helpfulness)

    count = ratings.size
    {
      readability: (total_readability / count.to_f).round(2),
      recommendation: (total_recommendation / count.to_f).round(2),
      helpfulness: (total_helpfulness / count.to_f).round(2),
    }
  end
end
