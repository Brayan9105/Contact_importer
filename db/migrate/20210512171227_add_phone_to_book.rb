class AddPhoneToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :column_phone, :integer
  end
end
