Types::SubmissionType = GraphQL::ObjectType.define do
  name "Submission"

  field :id, !types.ID
  field :track, !Types::InternalTrackType
  field :score, !types.Int
  field :playing, !types.Boolean
  field :myVote, Types::VoteType do
    resolve ->(submission, _, ctx) do
      submission.votes.detect { |vote| vote.user_id == ctx[:current_user]&.id }
    end
  end
end
