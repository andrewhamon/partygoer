Mutations::CreateUser = GraphQL::Relay::Mutation.define do
  name "CreateUser"
  return_field :token, !types.String

  input_field :phoneNumber, !types.String

  resolve ->(_, args, _) do
    user = User.find_or_create_by!(phone_number: args[:phoneNumber])
    session = Session.create!(user: user)
    SendVerificationPinWorker.perform_async(session.id)

    {
      token: session.token,
    }
  end
end
