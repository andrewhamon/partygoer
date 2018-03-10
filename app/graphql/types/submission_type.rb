Types::SubmissionType = GraphQL::ObjectType.define do
  name "Submission"

  field :id, !types.ID
  field :track, !Types::TrackType
  field :score, !types.Int
  field :playing, !types.Boolean
  field :myVote, Types::VoteType do
    resolve ->(obj, _, ctx) { obj.votes.find_by(user: ctx[:current_user]) }
  end
end
