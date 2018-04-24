require "rails_helper"

RSpec.describe User, type: :model do
  describe ".find_by_verified_token" do
    it "finds a user given a verified session token" do
      session = create(:session, :verified)

      expect(described_class.find_by_verified_token(session.token)).to eq session.user
    end

    it "returns nil if the session is unverified" do
      session = create(:session)

      expect(described_class.find_by_verified_token(session.token)).to be_nil
    end

    it "returns nil given an incorrect token" do
      _decoy_session = create(:session, :verified)
      _decoy_session2 = create(:session)

      expect(described_class.find_by_verified_token("oops")).to be_nil
    end
  end
end
