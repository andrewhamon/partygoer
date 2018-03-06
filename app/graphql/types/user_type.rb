Types::UserType = GraphQL::ObjectType.define do
  name "User"

  field :token, !types.String
end
