require 'test_helper'

class FinishedTimeDurationTest < ActiveSupport::TestCase

  test 'should remember length' do
    assert_equal 5, TimeDuration::Finished.new(5).length
  end

end
