class TrackSearch
  BANNED_TRACKS = [
    "free bird",
    "mambo",
    "never gonna give",
    "not unusual",
    "numa",
    "pussycat",
    "sandstorm",
    "white noise",
    "wonderwall",
  ].freeze

  attr_reader :query

  def initialize(query)
    @query = query
  end

  def results
    RSpotify::Track.search(query).reject(&method(:reject_track?))
  end

  private

  def reject_track?(track)
    name_blacklisted?(track) || too_long?(track)
  end

  def too_long?(track)
    track.duration_ms > 7.minutes.in_milliseconds
  end

  def name_blacklisted?(track)
    BANNED_TRACKS.any? { |name| track.name.downcase.include?(name) }
  end
end
