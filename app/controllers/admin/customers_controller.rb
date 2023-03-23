class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
   end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: !@customer.is_deleted) #有効か退会か反転させる
    redirect_to admin_customers_path
  end
end
