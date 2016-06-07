class CreateParticipacions < ActiveRecord::Migration
  def change
    create_table :participacions do |t|
      t.integer :deal_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :participacions, :deal_id
    add_index :participacions, :user_id
    add_index :participacions, [:deal_id, :user_id], unique: true
  end
end
