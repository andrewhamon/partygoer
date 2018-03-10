Types::PartyType = GraphQL::ObjectType.define do
  name "Party"

  field :name, !types.String
  field :active_submissions, !types[Types::SubmissionType] do
    resolve ->(obj, _, ctx) do
      obj.
        active_submissions.
        includes(:track).
        with_user_vote(ctx[:current_user])
    end
  end
end
