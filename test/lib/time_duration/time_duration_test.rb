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

  test 'should add to another duration' do

    @other_object = Object.new
    @other_object.extend(TimeDuration)
    @other_object.define_singleton_method(:length) { 10 }
    assert_equal 15, (@other_object + @object).length

  end

end
