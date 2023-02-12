FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.last_name }
    password { "p@ssw0rd" }
  end
end
