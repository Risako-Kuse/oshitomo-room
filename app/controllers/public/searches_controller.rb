class Public::SearchesController < ApplicationController #検索機能

  def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'customer'
			@records = Customer.search_for(@content, @method)
		else
			@records = Post.search_for(@content, @method)
		end
		@customer = current_customer
	end

end
