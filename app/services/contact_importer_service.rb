class ContactImporterService < Struct.new(:book, :user)
  def import
    indexes = set_indexes(book)
    CSV.foreach(file) do |row|
      contact = set_contact(row, indexes)
      invalid_contact = set_invalid_contact(row, indexes)

      unless valid_number_of_columns(row)
        invalid_contact.error_msg = 'Some fields from the contact are missing'
        invalid_contact.save
        next
      end

      unless contact.save
        invalid_contact.error_msg = contact.errors.full_messages.join(', ')
        invalid_contact.save
      end

    end
  end

  private

  def file
    ActiveStorage::Blob.service.path_for(book.file.key)
  end

  def valid_number_of_columns(row)
    row.count == 6
  end

  def set_indexes(book)
    {
      name: book.column_name - 1,
      dob: book.column_dob - 1,
      phone: book.column_phone - 1,
      address: book.column_address - 1,
      credit_card: book.column_credit_card - 1,
      email: book.column_email - 1
    }
  end

  def set_contact(row, indexes)
    book.contacts.build(
      name: row[indexes[:name]],
      dob: row[indexes[:dob]],
      telephone: row[indexes[:phone]],
      address: row[indexes[:address]],
      credit_card: row[indexes[:credit_card]],
      email: row[indexes[:email]],
      user_id: user.id
    )
  end

  def set_invalid_contact(row, indexes)
    book.invalid_contacts.build(
      name: row[indexes[:name]],
      dob: row[indexes[:dob]],
      telephone: row[indexes[:phone]],
      address: row[indexes[:address]],
      credit_card: row[indexes[:credit_card]],
      email: row[indexes[:email]],
      user_id: user.id
    )
  end

  # def processing_file(params)
  #   fields = ['name', 'date', 'phone', 'address', 'franchise', 'email']
  #   valid_contact = 0
  #
  #   file = ActiveStorage::Blob.service.path_for(self.file.key)
  #   CSV.foreach(file, headers: true) do |row|
  #     $contact = { errors: [], name: '', date: '', phone: '', address: '', credit_card: '', franchise: '', email: '', user_id: self[:user_id] }
  #     if row.size != 6
  #       add_format_error('size')
  #       create_contact($contact)
  #       break
  #     end
  #
  #     fields.each do |field|
  #         send("valid_#{field}", row[params["#{field}".to_sym].to_i])
  #     end
  #
  #     valid_contact += 1 if $contact[:errors].size == 0
  #     create_contact($contact)
  #   end
  #   valid_contact > 0 ? self.terminado! : self.fallido!
  # end
end
