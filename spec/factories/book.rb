FactoryBot.define do
  factory :book do
    filename { 'csv_file.csv' }
    column_name { 1 }
    column_dob { 2 }
    column_phone { 3 }
    column_address { 4 }
    column_credit_card { 5 }
    column_email { 6 }
    user
  end

  trait :valid_file do
    file { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "valid_contacts.csv"), 'text/csv') }
  end

  trait :failed_book do
    file { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "failed_book.csv"), 'text/csv') }
  end

  trait :invalid_file do
    file { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "pdf_file.pdf"), 'text/pdf') }
  end

  trait :invalid_book do
    file { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "invalid_book.csv"), 'text/csv') }
  end

  trait :without_filename do
    filename { "" }
  end

  trait :on_hold do
    status { 0 }
  end

  trait :processing do
    status { 1 }
  end

  trait :failed do
    status { 2 }
  end

  trait :terminated do
    status { 3 }
  end
end
