FactoryBot.define do
  factory :user do
    spotify_user
    sequence(:phone_number)
  end
end
