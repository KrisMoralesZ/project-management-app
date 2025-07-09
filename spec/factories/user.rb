FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    name { "Test" }
    last_name { "User" }

    association :organization
  end
end
