Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :search_results, types[Types::TrackType] do
    argument :query, !types.String

    resolve ->(_obj, args, _ctx) do
      JSON.parse(
        RSpotify::Track.search(args["query"]).to_json,
        object_class: OpenStruct,
      )
    end
  end
end
