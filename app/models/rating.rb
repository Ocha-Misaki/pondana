class Rating < ApplicationRecord
  belongs_to :having_book

  validates :readability, presence: true
  validates :recommendation, presence: true
  validates :helpfulness, presence: true
end
