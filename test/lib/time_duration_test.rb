require 'test_helper'
require 'time_duration'

class TimeDurationTest < ActiveSupport::TestCase

  setup do
    @object = Object.new
    @object.extend(TimeDuration)
    @object.define_singleton_method(:length) { 5 }
  end

  test 'should print out in the right format' do
  
    {
      10 => '00:00:10', 
      80 => '00:01:20',
      300 => '00:05:00',
      7586 => '02:06:26',
      86400 => '>= 1 day'
    }.each_pair do |length, expected|
      @object.define_singleton_method(:length) { length }
      assert_equal expected, @object.to_s
    end

  end

  test 'skip' do
    skip

    finished = FinishedTimeDuration.new(30) 
    added = finished + FinishedTimeDuration.new(20)
    assert_equal 50, added.length
    
    start_time = Time.now - 5
    added = finished + UnfinishedTimeDuration.new(start_time)
    assert_in_delta 35, added.length, 0.01

    added = finished + NullTimeDuration.new
    assert_equal 30, added.length

    added = finished + AggregateTimeDuration.new(finished)
    assert_equal 60, added.length

  end

end
