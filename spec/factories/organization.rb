FactoryBot.define do
  factory :organization do
    organization_name { "Test Organization" }
    subdomain { "test_org" }
    email { Faker::Internet.unique.email }
    password { "password123" }
  end
end
