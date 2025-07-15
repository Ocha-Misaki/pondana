class Rating < ApplicationRecord
  belongs_to :ownership

  validates :readability, presence: true
  validates :recommendation, presence: true
  validates :helpfulness, presence: true
end
