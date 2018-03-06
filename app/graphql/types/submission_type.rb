Types::SubmissionType = GraphQL::ObjectType.define do
  name "Submission"

  field :track, Types::TrackType
  field :score, !types.Int
end
