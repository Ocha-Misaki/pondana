class HavingBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :purchased_at, presence: true
end
