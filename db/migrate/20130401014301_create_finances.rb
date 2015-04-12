class CreateFinances < ActiveRecord::Migration
  def change
    create_table :finances do |t|
      t.date :date
      t.string :supporter_name
      t.float :cash_amount
      t.float :check_amount
      t.integer :check_number
      t.string :notes
      t.string :data_entry
      t.string :audit

      t.timestamps
    end
  end
end
