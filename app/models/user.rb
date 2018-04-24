# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  token            :string           not null
#  lat              :float
#  lng              :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  current_party_id :integer
#  spotify_user_id  :integer
#

class User < ApplicationRecord
  belongs_to :current_party, class_name: "Party", optional: true
  belongs_to :spotify_user, optional: true
  has_many :parties_hosted, class_name: "Party", foreign_key: "owner_id"
  has_many :votes
  has_many :submissions
  has_many :sessions

  def upvote!(submission)
    vote = votes.find_or_initialize_by(submission: submission)
    vote.update!(value: 1)
    vote.save!
    submission.update_score!
  end

  def downvote!(submission)
    vote = votes.find_or_initialize_by(submission: submission)
    vote.update!(value: -1)
    submission.update_score!
  end

  def unvote!(submission)
    vote = votes.find_by(submission: submission)
    vote.destroy!
    submission.update_score!
  end

  def find_vote_on(submission)
    votes.index_by(&:submission_id)[submission.id]
  end
end
