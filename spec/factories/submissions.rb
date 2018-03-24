FactoryBot.define do
  factory :submission do
    user
    track
    party
    score { rand(0..3) }

    trait :playing do
      queue_status :playing
    end

    trait :played do
      queue_status :played
    end

    trait :skipped do
      queue_status :skipped
    end
  end
end
