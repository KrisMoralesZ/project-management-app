FactoryBot.define do
  factory :organization do
    organization_name { "Test Organization" }
    subdomain { "test_org" }
    email { "org_test@test.com"  }
    password { "password123" }
  end
end
