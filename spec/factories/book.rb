FactoryBot.define do
  factory :book do
    file { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "csv_file.csv"), 'text/csv') }
    filename { 'csv_file.csv' }
    user
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
