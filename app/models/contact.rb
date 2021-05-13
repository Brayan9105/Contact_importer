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

  def valid_date
    if self.dob.present?
      begin
        return true if Date.iso8601(self.dob)
      rescue
        self.errors.add(:dob, 'bad format field')
      end
    else
      self.errors.add(:dob, 'Cant be blank')
    end
  end
end
