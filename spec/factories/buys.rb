FactoryBot.define do
  factory :buy do
    association :user
    association :item
  end
end
