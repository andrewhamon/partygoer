Types::SubscriptionType = GraphQL::ObjectType.define do
  name "Subscription"

  # field :partyChanged, !Types::PostType, "A post was published to the blog"
end
