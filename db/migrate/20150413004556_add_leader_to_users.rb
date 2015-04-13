class AddLeaderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :leader, :boolean
  end
end
