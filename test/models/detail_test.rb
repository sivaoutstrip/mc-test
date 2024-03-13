# == Schema Information
#
# Table name: details
#
#  id         :integer          not null, primary key
#  person_id  :integer          not null
#  email      :string           not null
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class DetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
