class AddNameAndDobToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :name, :string
    add_column :contacts, :dob, :string
    add_column :invalid_contacts, :name, :string
    add_column :invalid_contacts, :dob, :string
  end
end
