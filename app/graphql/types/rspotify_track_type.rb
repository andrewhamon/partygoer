Types::RSpotifyTrackType = GraphQL::ObjectType.define do
  interfaces [Types::TrackInterface]

  name "RSpotifyTrack"

  field :artists, !types[!types.String] do
    resolve ->(obj, _, _) { obj.artists.map(&:name) }
  end

  field :image, !types.String do
    resolve ->(obj, _, _) do
      obj.album.images.max_by { |img| img["width"] }["url"]
    end
  end
end
