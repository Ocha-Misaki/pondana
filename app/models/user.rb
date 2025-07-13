class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end
  has_many :having_books, dependent: :destroy
  has_many :interests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :books, through: :having_books
  has_many :interested_books, through: :interests, source: :book

  validates :name, presence: true
  validates :image, presence: true, blob: { content_type: ["image/png", "image/jpg", "image/jpeg"], size_range: 1..(5.megabytes) }

  def having?(book)
    books.exists?(book.id)
  end

  def interested?(book)
    interested_books.exists?(book.id)
  end
end
