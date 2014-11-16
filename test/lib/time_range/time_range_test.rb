require 'test_helper'
require 'time_range'

class TimeRangeTest < ActiveSupport::TestCase

  test 'should use the correct time duration class' do
    
    now = Time.now
    
    duration = TimeRange.new(now, now + 5).instance_variable_get(:@duration)
    assert duration.is_a? TimeDuration::Finished

    duration = TimeRange.new(now, nil).instance_variable_get(:@duration)
    assert duration.is_a? TimeDuration::Unfinished

    duration = TimeRange.new(nil, now).instance_variable_get(:@duration)
    assert duration.is_a? TimeDuration::Null

    duration = TimeRange.new(nil, nil).instance_variable_get(:@duration)
    assert duration.is_a? TimeDuration::Null

  end

end
