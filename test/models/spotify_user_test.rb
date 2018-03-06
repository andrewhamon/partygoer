# == Schema Information
#
# Table name: spotify_users
#
#  id               :integer          not null, primary key
#  sid              :string           not null
#  device_id        :string
#  token            :string           not null
#  token_expires_at :string           not null
#  refresh_token    :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class SpotifyUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
