class PostComment < ApplicationRecord  #コメント機能のモデル

  belongs_to :customer
  belongs_to :post

end
