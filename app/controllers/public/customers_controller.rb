class Public::CustomersController < ApplicationController
  before_action :ensure_guest_customer, only: [:edit] #ゲストログインで会員情報編集できないようにする

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
    # ↓ 会員のユーザー情報だけ取ってくる
    @customers = Customer.where(is_deleted: false)
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

  # フォロー一覧
  def followings
    customer = Customer.find(params[:customer_id])
    @followings = customer.followings
  end

  # フォロワー一覧
  def followers
    customer = Customer.find(params[:customer_id])
    @followers = customer.followers
  end

  # 退会
  def withdrawal
    @customer = current_customer
    if @customer.update(is_deleted: true, email: 'deleted_customer_'+@customer.id.to_s+@customer.email)
                        # ↑ is_deleted: true, だけだと一度退会したら同じアドレスでは入会できない。 email: 'deleted_customer_'+@customer.id.to_s+@customer.emailを付けることで再入会可能にする。
      reset_session
      flash[:notice] = "ながのCAKEを退会しました"
      redirect_to root_path
    end
  end


  private
  # ストロングパラメーター
  def customer_params
    params.require(:customer).permit(:name, :image, :address, :age, :oshi_name, :introduction)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to public_customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
