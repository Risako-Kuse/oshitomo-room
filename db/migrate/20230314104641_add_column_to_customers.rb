class AddColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :name, :string, null: false
    add_column :customers, :address, :string
    add_column :customers, :age, :integer
    add_column :customers, :image, :text
    add_column :customers, :oshi_name, :string
    add_column :customers, :introduction, :text
    add_column :customers, :is_deleted, :boolean, default: false

  end
end
