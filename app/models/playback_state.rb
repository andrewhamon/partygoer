class PlaybackState
  TRACK_CHANGE_THRESHOLD = 0.5.seconds

  def initialize(playing:, progress_ms:, duration_ms:)
    @playing = playing
    @progress_ms = progress_ms
    @duration_ms = duration_ms
  end

  def self.from_spotify_hash(spotify_hash)
    new(
      playing: spotify_hash["is_playing"],
      progress_ms: spotify_hash["progress_ms"],
      duration_ms: spotify_hash["item"]["duration_ms"],
    )
  end

  def playing?
    @playing
  end

  def progress
    (@progress_ms / 1000.0).seconds
  end

  def duration
    (@duration_ms / 1000.0).seconds
  end

  def time_left
    duration - progress
  end

  def track_almost_over?
    time_left < TRACK_CHANGE_THRESHOLD
  end
end
