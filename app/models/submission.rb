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

  enum queue_status: %i[queued playing played]

  scope :queue_order, -> { order_by_playing.order(score: :desc, created_at: :asc) }
  scope :order_by_playing, -> do
    order(<<-SQL)
      case #{table_name}.queue_status when #{queue_statuses[:playing]} then 0 else 1 end
    SQL
  end

  def update_score!
    update_attributes(score: votes.sum(:value))

    if score <= SKIP_THRESHOLD
      party.play_next_track!
    end
  end
end
