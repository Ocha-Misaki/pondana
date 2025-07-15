class RatingForm < ApplicationForm
  attr_reader :rating, :having_book

  attribute :readability, :integer
  attribute :recommendation, :integer
  attribute :helpfulness, :integer
  attribute :having_book_id, :integer

  validates :readability, :recommendation, :helpfulness, presence: true, inclusion: { in: 1..5 }

  def save
    return false unless valid?

    @having_book ||= HavingBook.find(having_book_id)
    @rating = @having_book.rating || @having_book.build_rating

    @rating.assign_attributes(
      readability: readability,
      recommendation: recommendation,
      helpfulness: helpfulness
    )
    @rating.save
  end

  def self.build_from_rating(rating)
    new(
      readability: rating&.readability,
      recommendation: rating&.recommendation,
      helpfulness: rating&.helpfulness,
      having_book_id: rating&.having_book_id
    )
  end
end
