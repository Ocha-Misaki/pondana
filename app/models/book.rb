class Book < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :description, presence: true
  validates :store_url, presence: true, uniqueness: { scope: :title }

  scope :default_order, -> { order(created_at: :desc) }
end
