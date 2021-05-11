class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :telephone, :address, :credit_card,
            :franchise, :email, presence: true
end
