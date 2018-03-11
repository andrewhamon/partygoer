BANNED_TRACKS = [
  "not unusual",
  "never gonna give",
  "pussycat",
  "sandstorm",
  "free bird",
  "wonderwall",
  "mambo",
  "white noise",
  "numa",
]

Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :party, Types::PartyType do
    resolve ->(*) { Party.current }
  end

  field :search_results, types[Types::TrackSearchType] do
    argument :query, !types.String

    resolve ->(_, args, _) do
      RSpotify::Track.
        search(args["query"]).
        reject do |track|
          BANNED_TRACKS.any? { |name| track.name.downcase.include?(name) } ||
            track.duration_ms > 7.minutes.in_milliseconds
        end
    end
  end
end
