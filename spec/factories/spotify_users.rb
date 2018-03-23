FactoryBot.define do
  factory :spotify_user do
    sequence(:sid)
    sequence(:token)
    sequence(:refresh_token)
    token_expires_at { 10.minutes.from_now }
  end
end
