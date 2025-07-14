FactoryBot.define do
  factory :project do
    title { "Example Project" }
    details { "Some details about the project" }
    expected_completion_date { 2.weeks.from_now }
    association :organization
  end
end
