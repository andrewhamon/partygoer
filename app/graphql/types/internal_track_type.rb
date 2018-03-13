Types::InternalTrackType = GraphQL::ObjectType.define do
  interfaces [Types::TrackInterface]

  name "InternalTrack"

  field :artists, !types[!types.String] do
    resolve ->(obj, _, _) do
      obj.artists.map { |artist| artist["name"] }
    end
  end

  field :image, !types.String do
    resolve ->(obj, _, _) do
      obj.album["images"].max_by { |img| img["width"] }["url"]
    end
  end
end
