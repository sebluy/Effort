require 'test_helper'
require 'time_duration'

class FinishedTimeDurationTest < ActiveSupport::TestCase

  test 'should print out in the right format' do

    assert_equal '00:00:10', FinishedTimeDuration.new(10).to_s
    assert_equal '00:01:20', FinishedTimeDuration.new(80).to_s
    assert_equal '00:05:00', FinishedTimeDuration.new(300).to_s
    assert_equal '02:06:26', FinishedTimeDuration.new(7586).to_s
    assert_equal '> 1 day', FinishedTimeDuration.new(86401).to_s
    
  end

  test 'should add to another time duration' do

    time = Time.now
    added = FinishedTimeDuration.new(10) + FinishedTimeDuration.new(20)
    assert_equal 30, added.length

  end

end
