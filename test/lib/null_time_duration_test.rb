require 'test_helper'
require 'time_duration'

class NullTimeDurationTest < ActiveSupport::TestCase
  
  test 'should have correct length' do
    
    assert_equal 0, NullTimeDuration.new.length
  
  end

  test 'should print out correctly' do
    
    assert_equal '00:00:00', NullTimeDuration.new.to_s

  end

end
