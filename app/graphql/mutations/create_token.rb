Mutations::CreateToken = GraphQL::Relay::Mutation.define do
  name "CreateToken"
  return_field :token, !types.String
  resolve ->(_, _, _) do
    user = User.create!

    {
      token: user.token
    }
  end
end
