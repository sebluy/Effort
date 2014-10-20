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

  test 'should calculate time spent' do

    discipline = Discipline.create
  
    5.times { discipline.blocks.create }

    offset = [ 10.seconds, 1.day, 3.days, 3.weeks, 3.months ] 

    discipline.blocks.each_with_index do |block, i|
      block.finish = Time.now - offset[i]
      block.start = block.finish - 1.second
      block.save
    end

    assert_equal 5.seconds, discipline.time_spent_all
    assert_equal 1.seconds, discipline.time_spent_today

  end
    

end
