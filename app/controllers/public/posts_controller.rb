class Public::PostsController < ApplicationController

  # ↓新規投稿機能
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @post = Post.new(post_params)
    # UserIDを取り出す
    @post.customer_id = current_customer.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @post.save
    # 4.Postのindex画面へリダイレクト
    redirect_to public_post_path(@post)
  end

  def index
    @customer = current_customer
    @post = Post.new
    # ↓ 退会してない会員の投稿だけ取ってくる
    @posts = Post.joins(:customer).where(customer: { is_deleted: false })
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
      @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post.id)
    else
      render :edit
    end
  end


  def destroy
    post = Post.find(params[:id])  # データ（レコード）を1件取得
    post.destroy  # データ（レコード）を削除
    redirect_to public_posts_path
  end


  private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:oshi_name, :post_name, :post_content)
  end

end
