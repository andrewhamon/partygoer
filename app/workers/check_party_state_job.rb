class CheckPartyStateJob
  include Sidekiq::Worker

  attr_reader :party

  # Change to the next track slightly before the current one ends
  TRACK_CHANGE_THRESHOLD = 0.5.seconds

  # Re-run this job at least this often
  MAX_WAIT = 60.seconds

  def perform(party_id)
    @party = Party.find_by(id: party_id)

    # In case party gets destroyed
    return unless party
    # Stop checking if party is dead
    return if 6.hours.ago > party.updated_at
    # Cant really do anything if not connected to a spotify account
    return unless party.owner.spotify_user

    if playing?
      if track_almost_over?
        play_next_track_and_requeue
      else
        requeue_after(time_left)
      end
    else
      play_next_track_and_requeue
    end
  end

  private

  delegate :playback_state, to: :party
  delegate :playing?, :time_left, :track_almost_over?, to: :playback_state

  def play_next_track_and_requeue
    now_playing = party.play_next_track!
    requeue_after_submission(now_playing)
  end

  def requeue_after(duration)
    adjusted_duration = [duration, MAX_WAIT].min - TRACK_CHANGE_THRESHOLD
    CheckPartyStateJob.perform_in(adjusted_duration, party.id)
  end

  def requeue_after_submission(submission)
    return requeue_after(MAX_WAIT) unless submission

    requeue_after(submission.track.duration)
  end
end
