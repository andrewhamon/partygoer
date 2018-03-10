Types::PartyType = GraphQL::ObjectType.define do
  name "Party"

  field :name, !types.String
  field :active_submissions, !types[Types::SubmissionType] do
    resolve ->(obj, _, ctx) do
      ctx[:current_user].reload

      obj.
        active_submissions.
        includes(:track)
    end
  end
end
