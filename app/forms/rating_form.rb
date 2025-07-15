class RatingForm < ApplicationForm
  attr_reader :rating, :ownership

  attribute :readability, :integer
  attribute :recommendation, :integer
  attribute :helpfulness, :integer
  attribute :ownership_id, :integer

  validates :readability, :recommendation, :helpfulness, presence: true, inclusion: { in: 1..5 }

  def save
    return false unless valid?

    @ownership ||= Ownership.find(ownership_id)
    @rating = @ownership.rating || @ownership.build_rating

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
      ownership_id: rating&.ownership_id
    )
  end
end
