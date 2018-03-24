FactoryBot.define do
  factory :submission do
    user
    track
    party
    score { rand(0..3) }

    trait :playing do
      playing true
    end
  end
end
