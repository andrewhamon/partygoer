Mutations::VerifyUser = GraphQL::Relay::Mutation.define do
  name "VerifyUser"
  return_field :verified, !types.Boolean

  input_field :pin, !types.String

  resolve ->(_, args, ctx) do
    user = ctx[:current_user]
    if ActiveSupport::SecurityUtils.secure_compare(user.pin, args[:pin])
      user.update!(verified: true)
    end
    {
      verified: user.verified,
    }
  end
end
