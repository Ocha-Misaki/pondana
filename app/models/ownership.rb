class Ownership < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one :rating, dependent: :destroy

  validates :book_id, uniqueness: { scope: :user_id, message: "すでに持っている本です" }
end
