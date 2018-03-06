Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :create_user, Mutations::CreateUser.field
end
