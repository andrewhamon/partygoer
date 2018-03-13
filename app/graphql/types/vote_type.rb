Types::VoteType = GraphQL::ObjectType.define do
  name "Vote"

  field :direction, !Types::VoteDirectionType do
    resolve ->(vote, _, _) do
      case vote.value
      when -1 then "DOWN"
      when 1 then "UP"
      end
    end
  end
end
