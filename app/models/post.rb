class Post < ApplicationRecord

  belongs_to :customer
  has_many :favorites, dependent: :destroy #イイね機能
  has_many :post_comments, dependent: :destroy #コメント機能

  #イイね機能↓引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べる記述。
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  # 検索方法分岐
  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(oshi_name: content).or(Post.where(post_name: content)).or(Post.where(post_content: content))
    elsif method == 'forward'
      Post.where('oshi_name LIKE ?', content + '%').or(Post.where('post_name LIKE ?', content + '%')).or(Post.where('post_content LIKE ?', content + '%'))
    elsif method == 'backward'
      Post.where('oshi_name LIKE ?', '%' + content).or(Post.where('post_name LIKE ?', '%' + content)).or(Post.where('post_content LIKE ?', '%' + content))
    else
      Post.where('oshi_name LIKE ?', '%' + content + '%').or(Post.where('post_name LIKE ?', '%' + content + '%')).or(Post.where('post_content LIKE ?', '%' + content + '%'))
    end
  end

end
