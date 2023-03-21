class CreatePublicPostComments < ActiveRecord::Migration[6.1]
  
  def change
    create_table :public_post_comments do |t|
      t.text :comment
      t.integer :customer_id
      t.integer :post_
      t.timestamps
    end
  end
  
end
