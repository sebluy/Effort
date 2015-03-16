require 'test_helper'

class FinishedTimeDurationTest < ActiveSupport::TestCase

  test 'should return a aggregate length' do
    durations = []
    1.upto(10) do |n|
      duration = TimeDuration::Finished.new(n)
      durations << duration
    end
    assert_equal 55, TimeDuration::Aggregate.new(*durations).length
  end

end
