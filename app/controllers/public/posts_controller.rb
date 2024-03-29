class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, except: [:show, :index]

  # ↓新規投稿機能
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @post = Post.new(post_params)
    # Google Natural Language API (自然言語処理) 感情分析 後から追加。
    @post.score = 0
    content_name_score = Language.get_data(post_params[:post_content] + post_params[:post_name])
    oshi_name_score = Language.get_data(post_params[:oshi_name])
    @post.score += content_name_score if content_name_score < 0 #0以下の時
    @post.score += oshi_name_score if oshi_name_score < 0 # 0以下の時
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
    @posts = Post.joins(:customer).where(customer: { is_deleted: false }).where('posts.score >= ?', 0.0) #２個目のwhereの後の文はスコアが０以下の場合は表示しない
  end

  def show
    @post_show = Post.find(params[:id])
    @post = Post.new
    @customer = @post_show.customer
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.customer.id == current_customer.id
    else
     redirect_to public_post_path(@post.id)
    end
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
    @post = Post.find(params[:id])
    if @post.customer.id == current_customer.id
     @post.destroy  # データ（レコード）を削除
     redirect_to public_posts_path
    else
     redirect_to public_post_path(@post.id)
    end
  end


  private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:oshi_name, :post_name, :post_content)
  end

end
