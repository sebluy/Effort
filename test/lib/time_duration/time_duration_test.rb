require 'test_helper'

class TimeDurationTest < ActiveSupport::TestCase

  setup do
    @object = TimeDuration::Finished.new(5.0)
  end

  test 'should print out in the right format' do
  
    { 10.seconds => '00:00:10', 
      1.minute + 20.seconds => '00:01:20',
      5.minutes => '00:05:00',
      2.hours + 6.minutes + 26.seconds => '02:06:26',
      1.5.days => '1.5 days'
    }.each_pair do |length, expected|
      @object.define_singleton_method(:length) { length }
      assert_equal expected, @object.to_s
    end

  end

  test 'should add to another duration' do

    @other_object = TimeDuration::Finished.new(10)
    assert_equal 15, (@object + @other_object).length

  end

  test 'unfinished should add to agregate' do
    now = Time.zone.now
    unfinished = TimeDuration::Unfinished.new(now - 10.seconds)
    agregate = TimeDuration::Aggregate.new(@object)
    sum = agregate + unfinished
    assert_in_delta 15.seconds, sum.length, 1.second
  end

  test 'unfinished should add to null' do
    now = Time.zone.now
    unfinished = TimeDuration::Unfinished.new(now - 10.seconds)
    null = TimeDuration::Null.new
    sum = null + unfinished
    assert_in_delta 10.seconds, sum.length, 1.second
  end

  test 'aggregate with unfinished should add to null' do
    now = Time.zone.now
    unfinished = TimeDuration::Unfinished.new(now - 10.seconds)
    aggregate = TimeDuration::Aggregate.new(unfinished)
    sum = TimeDuration::Null.new + aggregate
    assert_in_delta 10.seconds, sum.length, 1.second
  end

  test 'should compare to another duration' do

    @other_object = Object.new
    @other_object.extend(TimeDuration)

    @other_object.define_singleton_method(:length) { 10 }
    assert 1, @other_object <=> @object

    @other_object.define_singleton_method(:length) { 5 }
    assert 0, @other_object <=> @object
  
    @other_object.define_singleton_method(:length) { 0 }
    assert -1, @other_object <=> @object

  end

  test 'should equal another time duration' do
    
    @other_object = Object.new
    @other_object.extend(TimeDuration)
    @other_object.define_singleton_method(:length) { 5 }
    
    assert_equal @object, @other_object
  end

  test 'should equal a number of seconds' do
    assert_equal @object, 5.seconds
  end

  test 'initializer should choose the correct class' do
    
    time = Time.now

    assert TimeDuration.new(time, time + 5).is_a? TimeDuration::Finished
    assert TimeDuration.new(time, nil).is_a? TimeDuration::Unfinished
    assert TimeDuration.new(nil, time).is_a? TimeDuration::Null
    assert TimeDuration.new(nil, nil).is_a? TimeDuration::Null
  
  end

end
