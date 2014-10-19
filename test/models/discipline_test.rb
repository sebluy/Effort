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

  test 'should start a new block' do

    block = nil
    discipline = disciplines(:coding)

    assert_difference('discipline.blocks.count') do
      block = discipline.start_new_block
    end

    assert_equal block.discipline_id, discipline.id

  end

end
