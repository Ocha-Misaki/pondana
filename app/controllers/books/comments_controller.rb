class Books::CommentsController < Books::ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.book = @book
    if @comment.save
      redirect_to book_path(@book), notice: 'コメントが作成されました。'
    else
      redirect_to book_path(@book), alert: 'コメントの作成に失敗しました。'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    redirect_to book_path(@book), notice: 'コメントが削除されました。'
  end

  private

  def comment_params
    params.expect(comment: [:content])
  end
end
