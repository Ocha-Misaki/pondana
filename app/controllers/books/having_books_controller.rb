class Books::HavingBooksController < Books::ApplicationController
  def create
    having_book = current_user.having_books.build(book: @book, purchased_at: Time.current)
    having_book.save!
    redirect_to book_path(@book), notice: "持っている本に追加しました"
  end

  def destroy
    having_book = current_user.having_books.find(params[:id])
    having_book.destroy!
    redirect_to book_path(@book), notice: "持っている本から削除しました"
  end
end
