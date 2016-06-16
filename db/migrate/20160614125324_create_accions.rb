class CreateAccions < ActiveRecord::Migration
  def change
    create_table :accions do |t|
      t.integer :deal_id
      t.string :medio
      t.boolean :salida, default: true
      t.string :resultado
      t.text :comentario
      t.datetime :fecha
      t.boolean :hecha, default: false

      t.timestamps null: false
    end
    add_index :accions, :deal_id
  end
end
