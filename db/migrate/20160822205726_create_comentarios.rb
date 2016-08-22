class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.references :user, index: true, foreign_key: true
      t.references :accion, index: true, foreign_key: true
      t.text :texto

      t.timestamps null: false
    end
  end
end
