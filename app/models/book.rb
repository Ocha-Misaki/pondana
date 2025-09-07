class Book < ApplicationRecord
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
  validates :store_url, presence: true, uniqueness: { scope: :title }
  validates :image, presence: true, blob: { content_type: ["image/png", "image/jpg", "image/jpeg"], size_range: 1..(5.megabytes) }

  scope :default_order, -> { order(created_at: :desc) }

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
