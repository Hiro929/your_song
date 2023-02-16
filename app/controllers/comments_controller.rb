class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to post_path(comment.post), success: "コメントを作成しました！"
    else
      redirect_to post_path(comment.post), danger: "コメントの作成に失敗しました！"
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy!
    redirect_to post_path(comment.post), success: "投稿を削除しました！"
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end
