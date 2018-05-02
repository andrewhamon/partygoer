Types::PartyType = GraphQL::ObjectType.define do
  name "Party"

  field :id, !types.ID
  field :name, !types.String

  field :activeSubmissions, !types[!Types::SubmissionType] do
    resolve ->(party, _, _) do
      party.active_submissions.includes(:track, :votes)
    end
  end
end
