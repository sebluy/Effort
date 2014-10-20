require 'test_helper'
require 'duration_string'

class DurationStringTest < ActiveSupport::TestCase

  test 'should autoscale a duration' do
  
    time = 1.year + 3.months + 2.weeks + 4.days + 7.hours + 40.minutes +
            23.seconds
    converter = DurationString::Converter.new(time).autoscale

    quantities = converter.instance_variable_get(:@quantities)
    assert_equal 1, quantities[:years]
    assert_equal 3, quantities[:months]
    assert_equal 2, quantities[:weeks]
    assert_equal 4, quantities[:days]
    assert_equal 7, quantities[:hours]
    assert_equal 40, quantities[:minutes]
    assert_equal 23, quantities[:seconds]
  
  end

  test 'should print out an autoscaled duration' do

    time = 1.year + 3.months + 2.weeks
    
    string = DurationString::Converter.new(time).autoscale.to_s
    
    assert_equal '1 year 3 months', string

  end

  test 'should convert an amount of seconds to a string' do
    
    time = 5.hours + 567.minutes + 10.seconds
    
    string = DurationString.convert(time)
    
    assert_equal '14 hours 27 minutes', string
    
  end

end
