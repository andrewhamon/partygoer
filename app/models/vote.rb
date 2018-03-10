# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  submission_id :integer          not null
#  value         :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :submission

  validates :submission_id, uniqueness: { scope: :user_id }
  validates :value, inclusion: { in: [-1, 1] }
end
