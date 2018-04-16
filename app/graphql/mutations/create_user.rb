Mutations::CreateUser = GraphQL::Relay::Mutation.define do
  name "CreateUser"
  return_field :token, !types.String

  input_field :phoneNumber, !types.String

  resolve ->(_, args, _) do
    user = User.create!(phone_number: args[:phoneNumber])
    SendVerificationPinWorker.perform(user.id)

    {
      token: user.token,
    }
  end
end
