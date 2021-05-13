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

  def valid_phone
    if self.telephone.present?
      regex1 = /^[\(]\+[\d]{2}[\)][ ][\d]{3}[ ][\d]{3}[ ][\d]{2}[ ][\d]{2}$/
      regex2 = /^[\(]\+[\d]{2}[\)][ ][\d]{3}[-][\d]{3}[-][\d]{2}[-][\d]{2}$/
      self.errors.add(:telephone, 'bad format field') unless self.telephone.match(regex1) || self.telephone.match(regex2)
    else
      self.errors.add(:telephone, 'Cant be blank')
    end
  end
end
