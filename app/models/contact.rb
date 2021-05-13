class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :telephone, :address, :credit_card,
            :email, presence: true

  def valid_name
    if self.name.present?
      self.errors.add(:name, 'bad format field') if self.name.match(/[!$%^&*()_+|~=`{}\[\]:";'<>?,.Ç¨\|@#¢∞¬÷“”≠´\\]/)
    else
      self.errors.add(:name, 'Cant be blank')
    end
  end
end
