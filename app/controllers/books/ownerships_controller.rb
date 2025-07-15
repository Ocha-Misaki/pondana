class Books::OwnershipsController < Books::ApplicationController
  def create
    ownership = current_user.ownerships.build(book: @book)
    ownership.save!
    redirect_to book_path(@book), notice: "持っている本に追加しました"
  end

  def destroy
    ownership = current_user.ownerships.find(params[:id])
    ownership.destroy!
    redirect_to book_path(@book), notice: "持っている本から削除しました"
  end
end
