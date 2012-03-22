require 'test_helper'

class FollowingTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Following.new.valid?
  end
end
