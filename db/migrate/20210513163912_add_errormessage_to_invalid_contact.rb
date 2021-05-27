class AddErrormessageToInvalidContact < ActiveRecord::Migration[6.1]
  def change
    add_column :invalid_contacts, :error_msg, :text
  end
end
