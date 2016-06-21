class AddContactoIdToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :contacto_id, :integer
    add_foreign_key :deals, :contacto_id
    add_index :deals, :contacto_id
    remove_column :deals, :empresa_id
  end
end
