class CreateContactos < ActiveRecord::Migration
  def change
    create_table :contactos do |t|
      t.string :nombre
      t.string :apellido
      t.string :cargo
      t.string :tel
      t.string :dir
      t.string :email
      t.integer :ciudad
      t.date :bday
      t.integer :empresa_id, index: true, foreign_key: true
      t.text :familia
      t.text :comentarios

      t.timestamps null: false
    end
  end
end
