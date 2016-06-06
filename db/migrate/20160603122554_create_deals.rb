class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.references :user, index: true, foreign_key: true
      t.text :fuente
      t.integer :probabilidad
      t.text :estado
      t.text :empresa

      t.timestamps null: false
    end
    add_index :deals, [:user_id, :created_at]
  end
end
