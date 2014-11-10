require 'test_helper'
require 'time_duration'

class TimeDurationTest < ActiveSupport::TestCase

  test 'should print out in the right format' do

    assert_equal '00:00:10', TimeDuration.new(10).to_s
    assert_equal '00:01:20', TimeDuration.new(80).to_s
    assert_equal '00:05:00', TimeDuration.new(300).to_s
    assert_equal '02:06:26', TimeDuration.new(7586).to_s
    assert_equal '> 1 day', TimeDuration.new(86401).to_s
    
  end

  test 'should add to another time duration' do

    time = Time.now
    added = TimeDuration.new(10) + TimeDuration.new(20)
    assert_equal 30, added.length

  end

end
