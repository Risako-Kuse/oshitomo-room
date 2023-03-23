class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
     @posts = Post.all
  end

  def destroy
    post = Post.find(params[:id])  # データ（レコード）を1件取得
    post.destroy  # データ（レコード）を削除
    redirect_to admin_posts_path
  end
end
