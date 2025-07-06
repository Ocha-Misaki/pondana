class Genre < ApplicationRecord
  has_many :book_genres, dependent: :restrict_with_exception

  validates :name, presence: true
end
