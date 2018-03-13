PartygoerSchema = GraphQL::Schema.define do
  use(GraphQL::Subscriptions::ActionCableSubscriptions)

  mutation(Types::MutationType)
  query(Types::QueryType)
  subscription(Types::SubscriptionType)

  # TODO: figure out why this is needed
  resolve_type ->(obj, ctx) {}
end
