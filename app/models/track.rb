# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  sid        :string           not null
#  metadata   :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ApplicationRecord
  has_many :submissions, dependent: :destroy

  store_accessor :metadata, :uri, :href, :name, :type, :album, :artists,
                 :explicit, :played_at, :popularity, :disc_number, :duration_ms,
                 :is_playable, :linked_from, :preview_url, :context_type,
                 :external_ids, :track_number, :external_urls,
                 :available_markets

  def self.from_rspotify_track(track)
    t = find_or_initialize_by(sid: track.id)
    t.metadata = track.as_json
    t
  end

  def self.from_spotify_id(id)
    id = id.split(":").last
    track = RSpotify::Track.find(id)
    from_rspotify_track(track)
  end

  def duration
    (duration_ms / 1000.0).seconds
  end
end
