class Favorite < ApplicationRecord #イイね機能のモデル

  belongs_to :customer
  belongs_to :post
  
end
