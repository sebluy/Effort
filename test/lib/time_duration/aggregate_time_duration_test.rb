require 'test_helper'
require 'time_duration'

class FinishedTimeDurationTest < ActiveSupport::TestCase

  test 'should return a aggregate length' do
    durations = []
    1.upto(10) do |n|
      object = Object.new
      object.extend(TimeDuration)
      object.define_singleton_method(:length) { n }
      durations << object
    end
    assert_equal 55, TimeDuration::Aggregate.new(*durations).length
  end

end
