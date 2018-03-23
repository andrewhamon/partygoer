require "rails_helper"

RSpec.describe CheckPartyStateJob, type: :job do
  let(:party) { create(:party) }

  before do
    # Prevent infinite queueing loops since Sidekiq is in testing mode
    allow(CheckPartyStateJob).to receive(:perform_at).and_return(nil)

    # Avoid Spotify API calls
    allow_any_instance_of(SpotifyUser).to receive(:playback_state).and_return(fake_playback_state)
    allow_any_instance_of(SpotifyUser).to receive(:play).and_return(nil)
  end

  context "nothing is playing" do
    let(:playback_state) { { playing: false, progress: 0.minutes, duration: 2.minutes } }

    it "starts playing" do
      create(:submission, party: party)
      create(:submission, party: party)

      run_job

      expect(party.submissions.playing.count).to eq 1
    end
  end

  context "something is playing, but it's far from over" do
    let(:playback_state) { { playing: true, progress: 0.minutes, duration: 2.minutes } }

    it "doesn't change what's currently playing" do
      playing_submission = create(:submission, :playing, party: party)
      next_submission = create(:submission, party: party)

      run_job

      expect(playing_submission.reload).to be_playing
      expect(next_submission.reload).not_to be_playing
    end
  end

  context "we're close to the end of this track" do
    let(:playback_state) { { playing: true, progress: 4.999.minutes, duration: 5.minutes } }

    it "skips to the next track" do
      ending = create(:submission, :playing, party: party)
      up_next = create(:submission, party: party)

      run_job

      expect(up_next.reload).to be_playing
      expect(ending.reload).not_to be_playing
    end
  end

  private

  def run_job
    Sidekiq::Testing.inline! do
      CheckPartyStateJob.perform_async(party.id)
    end
  end

  def fake_playback_state
    PlaybackState.new(playback_state)
  end
end
