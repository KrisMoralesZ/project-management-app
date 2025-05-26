FactoryBot.define do
  factory :organization do
    sequence(:name) { |n| "Organization #{n}" }
    sequence(:subdomain) { |n| "org#{n}" }
    sequence(:email) { |n| "org#{n}@example.com" }
    password { "password123" }
  end
end
