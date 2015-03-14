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

end
