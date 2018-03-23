FactoryBot.define do
  factory :track do
    sequence(:sid)
    metadata do
      {
        "duration_ms" => 10,
      }
    end
  end
end
