class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :nombre
      t.string :nombre_legal
      t.string :tel
      t.string :email
      t.integer :ciudad
      t.string :dir

      t.timestamps null: false
    end
    add_index :empresas, :nombre, unique: true
    add_index :empresas, :nombre_legal, unique: true
  end
end
