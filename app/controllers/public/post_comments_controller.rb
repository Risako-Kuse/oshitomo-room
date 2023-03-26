class Public::PostCommentsController < ApplicationController #コメント機能

  def create #createアクションを追加  用途：コメントを作成する
    post = Post.find(params[:post_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to request.referer # 遷移元のURLにリダイレクトする
  end

  def destroy #destroyアクションを追加  用途：コメントを削除する
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy #自分のコメントしか消去できない
    redirect_to request.referer # 遷移元のURLにリダイレクトする
  end

  # ストロングパラメーター
  private

  def post_comment_params
    params.permit(:comment)
  end

end
