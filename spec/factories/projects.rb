FactoryBot.define do
  factory :project do
    title { "Example Project" }
    details { "Some project details" }
    expected_completion_date { Date.today + 10 }
    association :organization
  end
end
