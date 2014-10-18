require 'test_helper'

class BlockTest < ActiveSupport::TestCase

  test 'should calculate time spent correctly' do
    assert_equal 60, blocks(:one).time_spent
  end

end
