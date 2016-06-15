class AddUserToAccion < ActiveRecord::Migration
  def change
    add_reference :accions, :user, foreign_key: true, index: true
  end
end
