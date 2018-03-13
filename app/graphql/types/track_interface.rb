Types::TrackInterface = GraphQL::InterfaceType.define do
  name "TrackInterface"

  field :id, !types.ID
  field :name, !types.String
  field :uri, !types.String
  field :href, !types.String
  field :artists, !types[!types.String]
  field :image, !types.String
end
