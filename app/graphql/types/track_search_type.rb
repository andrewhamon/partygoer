Types::TrackSearchType = GraphQL::ObjectType.define do
  name "TrackSearch"

  field :id, !types.ID
  field :name, !types.String
  field :uri, !types.String
  field :href, !types.String

  field :artists, !types[!types.String] do
    resolve ->(obj, _, _) { obj.artists.map(&:name) }
  end

  field :image, !types.String do
    resolve ->(obj, _, _) do
      obj.album.images.max_by(&:width).url
    end
  end
end
