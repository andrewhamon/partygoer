FactoryBot.define do
  factory :party do
    name "Party"
    owner factory: :user
    lat 0
    lng 0
  end
end
