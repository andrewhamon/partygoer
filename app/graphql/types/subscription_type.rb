Types::SubscriptionType = GraphQL::ObjectType.define do
  name "Subscription"

  field :partyChanged, !Types::PartyType do
    resolve ->(_, _, _) { Party.current }
  end
end
