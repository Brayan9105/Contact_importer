class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :name, presence: true,
                   format: { without: /[!$%^&*()_+|~=`{}\[\]:";'<>?,.Ç¨\|@#¢∞¬÷“”≠´\\]/ }
  validates :telephone, presence: true,
                    format: { with: /[\(]\+[\d]{2}[\)][ ][\d]{3}[- ][\d]{3}[- ][\d]{2}[- ][\d]{2}/ }
  validates :email, presence: true,
                    uniqueness: { scope: :user_id },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :address, presence: true
  validates :dob, presence: true
  validates :credit_card, presence: true
  validate :date_is_iso8601
  validate :credit_card_format

  after_create :set_franchise

  def date_is_iso8601
    begin
      return true if Date.iso8601(self.dob)
    rescue
      self.errors.add(:dob, 'bad format')
    end
  end

  def credit_card_format
    self.errors.add(:credit_card, 'bad format') unless CreditCardDetector::Detector.new(self.credit_card).brand
  end

  def set_franchise
    franchise = CreditCardDetector::Detector.new(self.credit_card)
    self.update(franchise: franchise.brand_name,
                card_digits: self.credit_card.slice(0...4),
                credit_card: BCrypt::Password.create(self.credit_card)
    )
  end
end
