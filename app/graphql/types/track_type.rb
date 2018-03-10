Types::TrackType = GraphQL::ObjectType.define do
  name "Track"

  field :id, !types.ID
  field :name, !types.String
  field :uri, !types.String
  field :href, !types.String

  field :artists, !types[!types.String] do
    resolve ->(obj, _, _) do
      obj.artists.map(&:name)
    end
  end

  field :image, !types.String do
    resolve ->(obj, _, _) do
      obj.album.images.max_by(&:width).url
    end
  end
end
