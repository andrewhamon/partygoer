# == Schema Information
#
# Table name: parties
#
#  id         :integer          not null, primary key
#  owner_id   :integer          not null
#  name       :string           not null
#  lat        :float            not null
#  lng        :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Party < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :submissions, dependent: :destroy
  has_one :now_playing, ->{ playing }, class_name: "Submission"

  scope :current, -> { first }

  scope :near, ->(place, radius = 2000) {
    select("parties.*, earth_distance(ll_to_earth(#{place.lat}, #{place.lng}), ll_to_earth(lat, lng)) AS distance").
      where("earth_box(ll_to_earth(#{place.lat}, #{place.lng}), #{radius}) @> ll_to_earth(lat, lng) AND earth_distance(ll_to_earth(#{place.lat}, #{place.lng}), ll_to_earth(lat, lng)) < #{radius}").
      order("distance asc")
  }

  def play_next_track!
    submissions.where(playing: true).update_all(playing: false, played_at: Time.now)
    play_next_in_queue
  end

  def skip_to_next_track!
    submissions.where(playing: true).update_all(playing: false, skipped_at: Time.now)
    play_next_in_queue
  end

  def now_playing
    submissions.where(playing: true).first
  end

  private

  def play_next_in_queue
    next_submission = submissions.unplayed.first
    return unless next_submission

    owner.spotify_user&.play(next_submission.track)
    next_submission.update(playing: true)
    next_submission
  end
end
