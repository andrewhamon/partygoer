require "rails_helper"

RSpec.describe User, type: :model do
  describe "before create pin" do
    it "creates a 4-digit pin for the user" do
      user = create(:user)
      expect(user.pin.length).to eq 4
    end
  end
end
