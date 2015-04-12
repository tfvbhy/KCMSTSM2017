class AddUserIdToFinances < ActiveRecord::Migration
  def change
    add_column :finances, :user_id, :integer
    add_index :finances, :user_id
  end
end
