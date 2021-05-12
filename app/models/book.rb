class Book < ApplicationRecord
  enum status: { on_hold: 0, processing: 1, failed: 2, terminated: 3 }

  belongs_to :user
  has_many :contacts
  has_many :invalid_contacts

  has_one_attached :file

  validates :file, presence: true
  validate :csv_format

  after_create :set_filename

  def set_filename
    self.update(filename: self.file.blob.filename)
  end

  def csv_format
    if file.attached? && !file.content_type.in?(['text/csv'])
      errors.add(:file, 'Must be a CSV file')
    end
  end
end
