require 'test_helper'
require 'time_duration'

class UnfinishedTimeDurationTest < ActiveSupport::TestCase
  
  test 'should have correct length' do
    
    length = TimeDuration::Unfinished.new(Time.zone.now - 5).length
    assert_in_delta 5,  length, 0.01
  
  end

end
