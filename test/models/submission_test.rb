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

require "test_helper"

class SubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
