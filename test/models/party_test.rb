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

require "test_helper"

class PartyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
