Types::PartyType = GraphQL::ObjectType.define do
  name "Party"

  field :name, !types.String

  field :now_playing, Types::SubmissionType

  field :queue, !types[Types::SubmissionType] do
    resolve ->(obj, _, _) { obj.submissions.unplayed }
  end
end
