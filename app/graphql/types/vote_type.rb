Types::VoteType = GraphQL::ObjectType.define do
  name "Vote"

  field :id, !types.ID
  field :submission, !Types::SubmissionType

  field :direction, !Types::VoteDirectionType do
    resolve ->(obj, _, _) do
      case obj.value
      when 1 then "UP"
      when -1 then "DOWN"
      end
    end
  end
end
