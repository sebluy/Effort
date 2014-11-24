require 'test_helper'

class NullTimeDurationTest < ActiveSupport::TestCase
  
  test 'should have correct length' do
    
    assert_equal 0, TimeDuration::Null.new.length
  
  end

end
