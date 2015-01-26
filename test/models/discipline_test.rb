require 'test_helper'

class DisciplineTest < ActiveSupport::TestCase
  
  test 'should start a new block' do

    block = nil
    discipline = Discipline.create

    assert_difference('discipline.blocks.count') do
      block = discipline.start_new_block
    end

    assert_equal block.discipline_id, discipline.id

  end

  test 'should provide correct time_spent' do

    discipline = Discipline.create

    2.times { discipline.blocks.create }

    offset = [ 10.seconds, 3.days ]

    discipline.blocks.each_with_index do |block, i|
      block.finish = Time.now - offset[i]
      block.start = block.finish - 1.second
      block.save
    end

    assert_equal 1.second , discipline.time_spent(:today).length
    assert_equal 0.seconds, discipline.time_spent(:yesterday).length
    assert_equal 2.seconds, discipline.time_spent(:week).length

    assert_equal 1.seconds, Discipline.time_spent(:today).length
    assert_equal 0.seconds, Discipline.time_spent(:yesterday).length
    assert_equal 2.seconds, Discipline.time_spent(:week).length

  end

end
