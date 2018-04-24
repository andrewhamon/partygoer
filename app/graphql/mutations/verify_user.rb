Mutations::VerifyUser = GraphQL::Relay::Mutation.define do
  name "VerifyUser"
  return_field :verified, !types.Boolean

  input_field :pin, !types.String
  input_field :token, !types.String

  resolve ->(_, args, _ctx) do
    session = Session.find_by(token: args[:token])
    if ActiveSupport::SecurityUtils.secure_compare(session.pin, args[:pin])
      session.update!(verified: true)
    end
    {
      verified: session.verified,
    }
  end
end
