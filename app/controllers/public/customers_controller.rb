class Public::CustomersController < ApplicationController
  
  # ↓新規投稿機能
  def create
     # １.&2. データを受け取り新規登録するためのインスタンス作成
    @post = Post.new(book_params)
    # UserIDを取り出す
    @post.customer_id = current_customer.id
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @post.save
    # 4. トップ画面へリダイレクト
    redirect_to public_posts_path(@post)
  end
  
  def index
    @customers = Customer.all
    @post = Post.new
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @post = Post.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to public_customers_path
  end

  def withdrawal
  end

  
  private
  # ストロングパラメーター
  def customer_params
    params.require(:customer).permit(:name, :image, :address, :age, :oshi_name, :introduction)
  end

end
