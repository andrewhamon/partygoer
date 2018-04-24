FactoryBot.define do
  factory :session do
    user

    trait :verified do
      verified true
    end
  end
end
