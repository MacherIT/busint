class ChangeEmpresaToId < ActiveRecord::Migration
  def change
    remove_column :deals, :empresa, :text
    add_column    :deals, :empresa_id, :integer, index: true, foreign_key: true
  end
end
