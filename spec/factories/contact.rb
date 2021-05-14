FactoryBot.define do
  factory :contact do
    name { Faker::Artist.name }
    dob { '2021-05-13' }
    telephone { '(+57) 320 432 05 09' }
    address { Faker::Address.street_address }
    credit_card { '371449635398431' }
    franchise { 'American Express' }
    sequence(:email) { |n| "test#{}@mail.com" }
    book { create(:book, :valid_file) }
    user
  end
end
