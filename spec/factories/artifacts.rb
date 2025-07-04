FactoryBot.define do
  factory :artifact do
    name { "Sample artifact" }
    description { "This is a test artifact." }
    status { 1 }

    association :project
    association :creator, factory: :user
    association :assignee, factory: :user
  end
end
