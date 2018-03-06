Types::ArtistType = GraphQL::ObjectType.define do
  name "Artist"

  field :name, !types.String
end
