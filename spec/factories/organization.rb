FactoryBot.define do
  factory :organization do
    organization_name { "My Organization" }
    subdomain { "myorg" }
    email { "org@example.com" }
    password { "password123" }
  end
end
