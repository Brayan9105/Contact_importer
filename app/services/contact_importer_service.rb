class ContactImporterService < Struct.new(:book, :user)
  def import
    i = 0
    indexes = set_indexes(book)
    CSV.foreach(file) do |row|
      if i.zero?
        i += 1
        next
      end
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
      card_digits: 'unknow',
      franchise: 'unknow',
      email: row[indexes[:email]],
      user_id: user.id
    )
  end
end
