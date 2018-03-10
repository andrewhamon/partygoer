Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createUser, Mutations::CreateUser.field
  field :createVote, Mutations::CreateVote.field
  field :create_submission, Mutations::CreateSubmission.field
  field :create_token, Mutations::CreateToken.field
end
