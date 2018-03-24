require "rails_helper"

RSpec.describe Party, type: :model do
  let(:party) { create(:party) }

  describe "#active_submissions" do
    it "includes playing or queued submissions only, and sorts them" do
      queued2 = create(:submission, party: party, score: 1)
      playing = create(:submission, :playing, party: party, score: -2)
      queued1 = create(:submission, party: party, score: 2)

      _played = create(:submission, :played, party: party)
      _not_in_party = create(:submission, party: create(:party))

      expect(party.active_submissions).to eq [playing, queued1, queued2]
    end
  end

  describe "#play_next_track!" do
    it "plays the first queued, most highly-ranked track" do
      playing = create(:submission, :playing, party: party, score: -2)
      up_next = create(:submission, party: party, score: 2)

      _queued = create(:submission, party: party, score: 1)
      _played = create(:submission, :played, party: party)
      _not_in_party = create(:submission, score: 3, party: create(:party))

      # TODO eliminate the need for this mocking
      allow(party.owner).to receive_message_chain(:spotify_user, :play)

      party.play_next_track!

      expect(playing.reload).to_not be_playing
      expect(up_next.reload).to be_playing
    end
  end
end
