class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  has_many :favorites, dependent: :destroy #イイね機能
  has_many :post_comments, dependent: :destroy #コメント機能

   # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "reverse_of_relationships_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :relationships

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "relationships_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :reverse_of_relationships

  has_one_attached :image #画像投稿機能

  # ↓ 画像投稿機能
  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    image.variant(resize_to_limit: [width, height]).processed
 end

 # フォローしたときの処理
  def follow(customer_id)
    relationships.create(reverse_of_relationships_id: customer_id)
  end

  # フォローを外すときの処理
  def unfollow(customer_id)
    relationships.find_by(reverse_of_relationships_id: customer_id).destroy
  end

  # フォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end

   # 検索方法分岐
  def self.search_for(content, method)
    if method == 'perfect'
      Customer.where(name: content)
    elsif method == 'forward'
      Customer.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Customer.where('name LIKE ?', '%' + content)
    else
      Customer.where('name LIKE ?', '%' + content + '%')
    end
  end

end
