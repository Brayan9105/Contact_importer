class Book < ApplicationRecord
  enum status: { on_hold: 0, processing: 1, failed: 2, terminated: 3 }

  belongs_to :user
  has_many :contacts
  has_many :invalid_contacts

  has_one_attached :file

  validates :file, presence: true
  validates :column_name, :column_dob, :column_phone, :column_address,
            :column_credit_card, :column_franchise, :column_email, presence: true,
            inclusion: { in: 1..7 }
  validate :csv_format
  validate :different_index

  after_create :set_filename

  def set_filename
    self.update(filename: self.file.blob.filename)
  end

  def csv_format
    if file.attached? && !file.content_type.in?(['text/csv'])
      errors.add(:file, 'Must be a CSV file')
    end
  end

  def different_index
    indexes = [self.column_name, self.column_dob, self.column_phone, self.column_address,
              self.column_credit_card, self.column_franchise, self.column_email]

    if indexes.uniq.count != 7
      errors.add(:file_rows, 'The indexes must be different')
    end
  end
end
