# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?
   before_action :customer_state, only:[:create] #退会済みの会員がログインできないようにする


  def after_sign_in_path_for(resource)
    public_customers_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

  # 退会しているかを判断するメソッド（退会していた場合はサインアップ画面に遷移し、退会していない場合はログイン処理を実行する）
  def customer_state
  # 【処理内容1】 フォームに入力されたemailから該当するアカウントを検索して取得
    @customer = Customer.find_by(email: params[:customer][:email])
  # アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
  # 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別 &&
  # 【処理内容3】 is_deletedカラムの値で分岐させる(false=有効)
    if @customer.valid_password?(params[:customer][:password]) && !@customer.is_deleted == false
  # 【処理内容3-1】is_deletedがtrueなら退会しているのでサインアップ画面に遷移
      redirect_to new_customer_registration_path
  # 【処理内容3-2】is_deletedがfalseなら退会していないのでそのままcreateアクション(ログイン)を実行
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
