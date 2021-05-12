class AddContantfieldsToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :column_name, :integer
    add_column :books, :column_dob, :integer
    add_column :books, :column_address, :integer
    add_column :books, :column_credit_card, :integer
    add_column :books, :column_franchise, :integer
    add_column :books, :column_email, :integer
  end
end
