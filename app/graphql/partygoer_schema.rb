PartygoerSchema = GraphQL::Schema.define do
  use(GraphQL::Subscriptions::ActionCableSubscriptions)

  mutation(Types::MutationType)
  query(Types::QueryType)
  subscription(Types::SubscriptionType)
end
