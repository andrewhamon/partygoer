class Session < ApplicationRecord
  before_create :generate_token
  before_create :generate_pin

  belongs_to :user

  private

  def generate_token
    self.token ||= SecureRandom.uuid
  end

  def generate_pin
    return if pin?

    loop do
      self.pin = SecureRandom.random_number(9999).to_s.rjust(4, "0")
      break unless Session.exists?(pin: pin)
    end
  end
end
