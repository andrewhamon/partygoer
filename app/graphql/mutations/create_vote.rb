Mutations::CreateVote = GraphQL::Relay::Mutation.define do
  name "CreateVote"
  return_type Types::SubmissionType

  input_field :submissionId, !types.ID
  input_field :direction, !Types::VoteDirectionType

  resolve ->(_, args, ctx) do
    submission = Submission.find(args[:submissionId])
    user = ctx[:current_user]

    case args["direction"]
    when "UP" then user.upvote!(submission)
    when "DOWN" then user.downvote!(submission)
    end

    submission
  end
end
