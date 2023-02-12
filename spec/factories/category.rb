FactoryBot.define do
  factory :category do
    name { Faker::Name.unique.first_name }
  end
end
