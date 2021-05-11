class Book < ApplicationRecord
  enum status: { on_hold: 0, processing: 1, failed: 2, terminated: 3 }

  belongs_to :user
  has_many :contacts
  has_many :invalid_contacts

  has_one_attached :file

  validates :file, presence: true
end
