Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :party, Types::PartyType do
    resolve ->(*) { Party.current }
  end

  field :search_results, types[Types::TrackSearchType] do
    argument :query, !types.String

    resolve ->(_, args, _) { RSpotify::Track.search(args["query"]) }
  end
end
