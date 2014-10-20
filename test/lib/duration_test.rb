require 'test_helper'
require 'duration'

class DurationTest < ActiveSupport::TestCase

  test 'should create a new duration' do

    duration = Duration.new
    
    assert_equal 0, duration.quantity
    assert_equal :seconds, duration.unit
    
  end

  test 'should print out as string' do

    duration = Duration.new
  
    assert_equal '0.0 seconds', duration.to_s

  end

  test 'should convert between units' do

    duration = Duration.new(120, :minutes)
    duration.convert!(:hours)

    assert_equal '2.0 hours', duration.to_s

    duration = Duration.new(6, :seconds)
    duration.convert!(:minutes)

    assert_equal '0.1 minutes', duration.to_s
  
  end

end
