class Books::InterestsController < Books::ApplicationController
  def create
    interest = current_user.interests.build(book: @book)
    interest.save!
    redirect_to book_path(@book), notice: "気になっている本に追加しました"
  end

  def destroy
    interest = current_user.interests.find(params[:id])
    interest.destroy!
    redirect_to book_path(@book), notice: "気になっている本から削除しました"
  end
end
