FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name.downcase }
    sequence(:email) { |n| "test#{n}@mail.com" }
    password { 'password' }
  end
end
