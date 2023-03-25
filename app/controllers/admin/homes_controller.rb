class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @customers = Customer.all
  end

   def destroy
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: !@customer.is_deleted) #有効か退会か反転させる
    redirect_to admin_customers_path
  end

end
