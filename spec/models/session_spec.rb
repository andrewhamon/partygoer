require "rails_helper"

RSpec.describe Session, type: :model do
  describe "before create pin" do
    it "generates a 4-digit pin" do
      session = create(:session)
      expect(session.pin.length).to eq 4
    end
  end
end
