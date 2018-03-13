Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createSubmission, Mutations::CreateSubmission.field
  field :createUser, Mutations::CreateUser.field
  field :createVote, Mutations::CreateVote.field
end
