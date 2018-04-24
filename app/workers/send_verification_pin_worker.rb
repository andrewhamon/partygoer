class SendVerificationPinWorker
  include Sidekiq::Worker

  TWILIO_ACCOUNT_SID = ENV.fetch("TWILIO_ACCOUNT_SID")
  TWILIO_AUTH_TOKEN = ENV.fetch("TWILIO_AUTH_TOKEN")
  TWILIO_PHONE_NUMBER = ENV.fetch("TWILIO_PHONE_NUMBER")

  attr_reader :session

  def perform(session_id)
    @session = Session.find(session_id)
    twilio_client.messages.create(
      to: session.user.phone_number,
      from: TWILIO_PHONE_NUMBER,
      body: "Your PIN is #{session.pin}",
    )
  end

  private

  def twilio_client
    Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
  end
end
