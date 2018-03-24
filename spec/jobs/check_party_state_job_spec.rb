require "rails_helper"

RSpec.describe CheckPartyStateJob, type: :job do
  let(:party) { create(:party) }

  before do
    # Avoid Spotify API calls
    allow_any_instance_of(SpotifyUser).to receive(:playback_state).and_return(fake_playback_state)
    allow_any_instance_of(SpotifyUser).to receive(:play)
  end

  context "nothing is playing" do
    let(:playing) { false }
    let(:progress) { 0.minutes }
    let(:duration) { 2.minutes }

    it "starts playing" do
      up_next = create(:submission, party: party, score: 1)
      create(:submission, party: party, score: 0)

      run_job_and_expect_requeue_after(up_next.track.duration)

      expect(party.submissions.playing.count).to eq 1
    end
  end

  context "something is playing, but it's far from over" do
    let(:playing) { true }
    let(:progress) { 0.minutes }
    let(:duration) { 10.seconds }

    it "doesn't change what's currently playing" do
      playing_submission = create(:submission, :playing, party: party)
      next_submission = create(:submission, party: party)

      run_job_and_expect_requeue_after(10.seconds)

      expect(playing_submission.reload).to be_playing
      expect(next_submission.reload).not_to be_playing
    end
  end

  context "we're close to the end of this track" do
    let(:playing) { true }
    let(:progress) { 4.999.minutes }
    let(:duration) { 5.minutes }

    it "skips to the next track" do
      ending = create(:submission, :playing, party: party)
      up_next = create(:submission, party: party)

      run_job_and_expect_requeue_after(up_next.track.duration)

      expect(up_next.reload).to be_playing
      expect(ending.reload).not_to be_playing
    end
  end

  private

  def run_job_and_expect_requeue_after(duration)
    expect_requeue_after(duration)

    Sidekiq::Testing.inline! do
      described_class.perform_async(party.id)
    end
  end

  def expect_requeue_after(expected_duration)
    matching_duration = be_within(1.second).of(expected_duration)

    expect(described_class).to receive(:perform_in).with(matching_duration, anything)
  end

  def fake_playback_state
    PlaybackState.new(playing: playing, progress: progress, duration: duration)
  end
end
