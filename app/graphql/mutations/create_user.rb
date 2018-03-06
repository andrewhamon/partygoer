Mutations::CreateUser = GraphQL::Relay::Mutation.define do
  name "CreateUser"
  return_type Types::UserType
  resolve ->(_, _, _) { User.create! }
end
