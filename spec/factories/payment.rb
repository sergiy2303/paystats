FactoryBot.define do
  factory :payment do
    amount 10
    date { Date.current }
    notes { Faker::Company.industry }
  end
end
