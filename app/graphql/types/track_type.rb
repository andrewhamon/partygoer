Types::TrackType = GraphQL::ObjectType.define do
  name "Track"

  field :id, !types.ID
  field :sid, !types.ID
  field :name, !types.String
  field :artists, !types[Types::ArtistType]
  field :uri, !types.String
  field :href, !types.String

  field :artist_sentence do
    type !types.String
    resolve ->(obj, _, _) { obj.artists.map(&:name).join(", ") }
  end

  field :images do
    type !types[Types::ImageType]
    resolve ->(obj, _, _) { obj.album.images }
  end
end
