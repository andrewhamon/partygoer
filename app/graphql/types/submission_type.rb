Types::SubmissionType = GraphQL::ObjectType.define do
  name "Submission"

  field :id, !types.ID
  field :track, !Types::TrackType
  field :score, !types.Int
  field :playing, !types.Boolean
  field :myVote, Types::VoteType do
    resolve ->(obj, _, ctx) do
      ctx[:current_user]&.find_vote_on(obj)
    end
  end
end
