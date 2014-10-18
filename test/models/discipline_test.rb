require 'test_helper'

class DisciplineTest < ActiveSupport::TestCase
  
  test 'should calculate total time spent correctly' do
    assert_equal 120, disciplines(:coding).total_time_spent
  end

end
