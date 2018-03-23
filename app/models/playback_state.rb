class PlaybackState
  TRACK_CHANGE_THRESHOLD = 0.5.seconds

  attr_reader :progress, :duration

  def initialize(playing:, progress:, duration:)
    @playing = playing
    @progress = progress
    @duration = duration
  end

  def self.from_spotify_hash(spotify_hash)
    new(
      playing: spotify_hash["is_playing"],
      progress: (spotify_hash["progress_ms"] / 1000.0).seconds,
      duration: (spotify_hash["item"]["duration_ms"] / 1000.0).seconds,
    )
  end

  def playing?
    @playing
  end

  def time_left
    duration - progress
  end

  def track_almost_over?
    time_left < TRACK_CHANGE_THRESHOLD
  end
end
