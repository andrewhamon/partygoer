Types::SubmissionType = GraphQL::ObjectType.define do
  name "Submission"

  field :id, !types.ID
  field :track, !Types::InternalTrackType
  field :score, !types.Int
  field :playing, !types.Boolean
  field :myVoteDirection, !Types::VoteDirectionType do
    resolve ->(*) { "UP" }
  end
end
