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

require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
