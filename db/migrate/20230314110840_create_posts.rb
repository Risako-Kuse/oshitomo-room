class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: alse
      t.string :oshi_name, null: false
      t.string :post_name, null: false
      t.text :post_content, null: false
      t.timestamps
    end
  end
end
