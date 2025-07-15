class Ownerships::RatingsController < Ownerships::ApplicationController
  def create
    @rating_form = RatingForm.new(rating_form_params.merge(ownership_id: @ownership.id))
    if @rating_form.save
      redirect_to book_path(@ownership.book), notice: "評価を保存しました"
    else
      redirect_to book_path(@ownership.book), alert: "評価の保存に失敗しました"
    end
  end

  def update
    @rating_form = RatingForm.new(rating_form_params.merge(ownership_id: @ownership.id))
    if @rating_form.save
      redirect_to book_path(@ownership.book), notice: "評価を更新しました"
    else
      redirect_to book_path(@ownership.book), alert: "評価の更新に失敗しました"
    end
  end

  private

  def rating_form_params
    params.fetch(:rating_form, {}).permit(:readability, :recommendation, :helpfulness)
  end
end
