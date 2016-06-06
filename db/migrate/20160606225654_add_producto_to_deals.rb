class AddProductoToDeals < ActiveRecord::Migration
  def change
    add_reference :deals, :producto, index: true, foreign_key: true
  end
end
