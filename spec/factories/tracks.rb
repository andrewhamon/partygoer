FactoryBot.define do
  factory :track do
    sequence(:sid)

    transient do
      duration { rand(0..50).seconds }
    end

    metadata do
      {
        "duration_ms" => duration.in_milliseconds,
      }
    end
  end
end
