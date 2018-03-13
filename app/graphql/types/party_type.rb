Types::PartyType = GraphQL::ObjectType.define do
  name "Party"

  field :name, !types.String

  field :activeSubmissions, !types[!Types::SubmissionType] do
    resolve ->(party, _, ctx) do
      ctx[:current_user]&.reload

      party.active_submissions.includes(:track)
    end
  end
end
