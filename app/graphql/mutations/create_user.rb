Mutations::CreateUser = GraphQL::Relay::Mutation.define do
  name "CreateUser"
  return_field :token, !types.String

  resolve ->(_, _, ctx) do
    {
      token: (ctx[:current_user] || User.create!).token
    }
  end
end
