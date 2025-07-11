class HavingBook < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one :rating, dependent: :destroy

  validates :purchased_at, presence: true
end
