FactoryBot.define do
  factory :comment do
    content { "This is a sample comment." }
    association :user
  end
end
