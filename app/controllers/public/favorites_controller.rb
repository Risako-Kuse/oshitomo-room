class Public::FavoritesController < ApplicationController #イイね機能

  def create
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: post.id)
    favorite.save
    redirect_to request.referer ## 遷移元のURLにリダイレクトする
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to request.referer # 遷移元のURLにリダイレクトする
  end
end
