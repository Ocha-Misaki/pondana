class OwnershipsController < ApplicationController
  def create
    item = JSON.parse(params[:book])
    book = Book.create_from_store(item)
    ownership = current_user.ownerships.build(book: book)
    ownership.save!
    redirect_to book_path(book), notice: "持っている本に追加しました"
  end

  def destroy
    ownership = current_user.ownerships.find_by(id: params[:id])
    ownership.destroy!
    redirect_to book_path(ownership.book), notice: "持っている本から削除しました"
  end
end
