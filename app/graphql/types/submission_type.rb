Types::SubmissionType = GraphQL::ObjectType.define do
  name "Submission"

  field :id, !types.ID
  field :track, Types::TrackType
  field :score, !types.Int
  field :playing, !types.Boolean
end
