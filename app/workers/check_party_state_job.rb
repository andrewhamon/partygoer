class CheckPartyStateJob
  include Sidekiq::Worker

  # Not real crossfade, but soonest we change tracks
  CROSSFADE_TIME_MS = 500

  MAX_WAIT_MS = 60 * 1000

  def perform(party_id)
    @party = Party.find_by(id: party_id)
    # In case party gets destroyed
    return unless party
    # Stop checking if party is dead
    return if 6.hours.ago > party.updated_at
    # Cant really do anything if not connected to a spotify account
    return unless party.owner.spotify_user

    playback_state = party.owner.spotify_user.playback_state

    is_playing = playback_state["is_playing"]
    # If nothing playing, play the next track
    unless is_playing
      Rails.logger.info("Nothing playing, playing next")
      now_playing = party.play_next_track!
      wait_for_track(now_playing)
      return
    end

    progress_ms = playback_state["progress_ms"]
    duration_ms = playback_state["item"]["duration_ms"]
    time_left_ms = duration_ms - progress_ms

    # If almost over, go ahead and play next track
    if time_left_ms < CROSSFADE_TIME_MS
      Rails.logger.info("Close to new track, playing next")
      now_playing = party.play_next_track!
      wait_for_track(now_playing)
      return
    # else wait til end of current track
    else
      Rails.logger.info("Next track far away, waiting")
      wait_time = time_left_ms.to_f - CROSSFADE_TIME_MS
      wait_for(wait_time)
      return
    end
  rescue StandardError => e
    # In case I really fucked up
    Rails.logger.error("Rescued in CheckPartyStateJob for party #{party_id} named #{party.name}")
    Rails.logger.error(e)
    Rails.logger.error(e.backtrace)
    wait_for(MAX_WAIT_MS)
  end

  private

  def party
    @party
  end

  def wait_for(time_ms)
    wait_time_ms = [time_ms, MAX_WAIT_MS].min
    wait_time_s = (wait_time_ms - CROSSFADE_TIME_MS) / 1000
    CheckPartyStateJob.set(wait_until: wait_time_s.seconds.from_now).perform_later(party.id)
  end

  def wait_for_track(submission)
    return wait_for(MAX_WAIT_MS) unless submission
    wait_time_ms = (submission.track.duration_ms - CROSSFADE_TIME_MS) / 1000
    wait_for(wait_time_ms)
  end
end
