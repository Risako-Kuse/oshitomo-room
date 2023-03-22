class Relationship < ApplicationRecord #フォロー/フォロワー機能
  # class_name: "User"でUserモデルを参照
  belongs_to :relationships, class_name: "Customer" #follower_id : フォローしたユーザー
  belongs_to :reverse_of_relationships, class_name: "Customer" #followed_id : フォローされたユーザー
end
