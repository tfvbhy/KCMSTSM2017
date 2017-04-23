class AddColeaderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coleader, :boolean
  end
end
