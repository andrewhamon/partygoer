Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :create_submission, Mutations::CreateSubmission.field
  field :create_token, Mutations::CreateToken.field
end
