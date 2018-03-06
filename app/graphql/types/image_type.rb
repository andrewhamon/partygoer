Types::ImageType = GraphQL::ObjectType.define do
  name "Image"

  field :url, !types.String
  field :width, !types.Int
  field :height, !types.Int
end
