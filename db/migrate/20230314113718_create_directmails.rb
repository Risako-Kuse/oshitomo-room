class CreateDirectmails < ActiveRecord::Migration[6.1]
  def change
    create_table :directmails do |t|
      t.integer :directmail_space_id, null: false
      t.text :message, null: false
      t.timestamps
    end
  end
end
