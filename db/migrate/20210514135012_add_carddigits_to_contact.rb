class AddCarddigitsToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :card_digits, :string
    add_column :invalid_contacts, :card_digits, :string
  end
end
