class Public::SearchesController < ApplicationController #検索機能
  before_action :authenticate_user! #ログインしたもののみ使用
  
  	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = Customer.search_for(@content, @method)
		else
			@records = Post.search_for(@content, @method)
		end
	end
	
end
