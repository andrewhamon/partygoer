class CheckPartyStateJob
  include Sidekiq::Worker

  attr_reader :party

  # Change to the next track slightly before the current one ends
  TRACK_CHANGE_THRESHOLD = 500

  MAX_WAIT_MS = 60 * 1000

  def perform(party_id)
    @party = Party.find_by(id: party_id)

    # In case party gets destroyed
    return unless party
    # Stop checking if party is dead
    return if 6.hours.ago > party.updated_at
    # Cant really do anything if not connected to a spotify account
    return unless party.owner.spotify_user

    if paused?
      play_next_track_and_requeue
      return
    end

    if track_almost_over?
      play_next_track_and_requeue
    else
      wait_time = time_left_ms.to_f - TRACK_CHANGE_THRESHOLD
      wait_for(wait_time)
    end
  end

  private

  def paused?
    !playback_state["is_playing"]
  end

  def progress_ms
    playback_state["progress_ms"]
  end

  def duration_ms
    playback_state["item"]["duration_ms"]
  end

  def time_left_ms
    duration_ms - progress_ms
  end

  def track_almost_over?
    time_left_ms < TRACK_CHANGE_THRESHOLD
  end

  def playback_state
    party.owner.spotify_user.playback_state
  end

  def play_next_track_and_requeue
    now_playing = party.play_next_track!
    wait_for_track(now_playing)
  end

  def wait_for(time_ms)
    wait_time_ms = [time_ms, MAX_WAIT_MS].min
    wait_time_s = (wait_time_ms - TRACK_CHANGE_THRESHOLD) / 1000
    CheckPartyStateJob.perform_at(wait_time_s.seconds.from_now, party.id)
  end

  def wait_for_track(submission)
    return wait_for(MAX_WAIT_MS) unless submission
    wait_time_ms = (submission.track.duration_ms - TRACK_CHANGE_THRESHOLD) / 1000
    wait_for(wait_time_ms)
  end
end
