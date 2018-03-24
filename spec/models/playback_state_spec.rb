require "rails_helper"

RSpec.describe PlaybackState, type: :model do
  describe ".from_spotify_hash" do
    it "initializes values from a Spotify's playback_state hash" do
      state = described_class.from_spotify_hash(
        "is_playing" => true,
        "progress_ms" => 5_000,
        "item" => { "duration_ms" => 120_000 },
      )

      expect(state.playing?).to be true
      expect(state.progress).to eq 5.seconds
      expect(state.duration).to eq 2.minutes
    end
  end
end
