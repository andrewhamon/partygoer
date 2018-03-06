# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  track_id   :integer          not null
#  party_id   :integer          not null
#  score      :integer          default(0), not null
#  played_at  :datetime
#  skipped_at :datetime
#  playing    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Submission < ApplicationRecord
  SKIP_THRESHOLD = -4
  belongs_to :user
  belongs_to :track
  belongs_to :party, touch: true

  has_many :votes, dependent: :destroy

  scope :unplayed, -> { where(playing: false, played_at: nil, skipped_at: nil).order(score: :desc, id: :asc) }

  def update_score!
    update_attributes(score: votes.sum(:value))

    if score <= SKIP_THRESHOLD
      party.skip_to_next_track!
    end
  end
end