class Public::CustomersController < ApplicationController

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

  def withdrawal_check
  end

  def withdrawal
  end

     private

  def customer_params
    params.require(:customer).permit(:name, :image, :address, :age, :oshi_name, :introduction)
  end

end
