class AddPosesionToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :posesion, :boolean, default: true
  end
end
