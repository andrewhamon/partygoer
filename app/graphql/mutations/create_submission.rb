Mutations::CreateSubmission = GraphQL::Relay::Mutation.define do
  name "CreateSubmission"
  return_type Types::SubmissionType

  input_field :spotify_track_id, !types.String

  resolve ->(obj, args, ctx) do
    track = Track.from_spotify_id(args[:spotify_track_id])
    track.save!

    submission = Submission.create!(
      track: track,
      party: Party.current,
      user: ctx[:current_user],
    )

    ctx[:current_user].upvote!(submission)

    submission
  end
end
