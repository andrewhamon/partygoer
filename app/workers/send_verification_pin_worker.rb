class SendVerificationPinWorker
  include Sidekiq::Worker

  TWILIO_ACCOUNT_SID = ENV.fetch("TWILIO_ACCOUNT_SID")
  TWILIO_AUTH_TOKEN = ENV.fetch("TWILIO_AUTH_TOKEN")
  TWILIO_PHONE_NUMBER = ENV.fetch("TWILIO_PHONE_NUMBER")

  attr_reader :user

  def perform(user_id)
    @user = User.find(user_id)
    twilio_client.messages.create(
      to: user.phone_number,
      from: TWILIO_PHONE_NUMBER,
      body: "Your PIN is #{user.pin}",
    )
  end

  private

  def twilio_client
    Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
  end
end
