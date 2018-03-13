Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :party, !Types::PartyType do
    resolve ->(*) { Party.current }
  end

  field :searchResults, !types[!Types::RSpotifyTrackType] do
    argument :query, !types.String
    resolve ->(_, args, _) { TrackSearch.new(args["query"]).results }
  end
end
