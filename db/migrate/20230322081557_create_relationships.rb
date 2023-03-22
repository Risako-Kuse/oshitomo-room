class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :relationships_id
      t.integer :reverse_of_relationships_id

      t.timestamps
    end
  end
end
