class RatingForm < ApplicationForm
  attr_reader :rating, :having_book

  attribute :readability, :integer
  attribute :recommendation, :integer
  attribute :helpfulness, :integer

  validates :readability, :recommendation, :helpfulness, presence: true, inclusion: { in: 1..5 }

  def call(having_book = nil, params = {})
    @having_book = having_book
    return unless @having_book

    @rating = @having_book.rating || @having_book.build_rating
    defaults = {
      readability: @rating.readability,
      recommendation: @rating.recommendation,
      helpfulness: @rating.helpfulness,
    }

    self.assign_attributes(defaults.merge(params))
    self
  end

  def save
    return false unless valid?

    @rating.assign_attributes(
      readability: readability,
      recommendation: recommendation,
      helpfulness: helpfulness
    )
    @rating.save
  end
end
