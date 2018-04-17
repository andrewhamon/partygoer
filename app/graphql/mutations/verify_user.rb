Mutations::VerifyUser = GraphQL::Relay::Mutation.define do
  name "VerifyUser"
  return_field :verified, !types.Boolean

  input_field :pin, !types.String
  input_field :token, !types.String

  resolve ->(_, args, ctx) do
    user = User.find_by(token: args[:token])
    if ActiveSupport::SecurityUtils.secure_compare(user.pin, args[:pin])
      user.update!(verified: true)
    end
    {
      verified: user.verified,
    }
  end
end
