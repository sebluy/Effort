require 'test_helper'

class DisciplineTest < ActiveSupport::TestCase
  
  test 'should calculate total time spent correctly' do
    assert_equal 150, disciplines(:coding).time_spent_all
  end

  test 'should calculate time spent today correctly' do
    assert_equal 30, disciplines(:coding).time_spent_today
  end

  test 'should return todays blocks' do
    assert_equal 1, disciplines(:coding).todays_blocks.size
  end

end
