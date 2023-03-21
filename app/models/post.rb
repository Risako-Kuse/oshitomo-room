class Post < ApplicationRecord

  belongs_to :customer
  has_many :favorites, dependent: :destroy #イイね機能
  has_many :post_comments, dependent: :destroy #コメント機能

  #イイね機能↓引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる記述。
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end


end
