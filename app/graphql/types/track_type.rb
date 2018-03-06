Types::TrackType = GraphQL::ObjectType.define do
  name "Track"

  field :id, !types.ID
  field :name, !types.String
  field :artists, !types[Types::ArtistType]
  field :uri, !types.String
  field :href, !types.String

  field :images do
    type !types[Types::ImageType]
    resolve ->(obj, _, _) { obj.album.images }
  end
end
