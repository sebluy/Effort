require 'test_helper'

class SummaryTest < ActiveSupport::TestCase

  setup do
    discipline_a = Discipline.create(title: 'a')
    discipline_b = Discipline.create(title: 'b')
    
    discipline_a.blocks << [ block_at(2.days.ago), block_at(1.day.ago) ]
    discipline_b.blocks << [ block_at(3.days.ago), block_at(1.day.ago) ]
  
    @summary = Summary.new(Block.all, Discipline.all)
  end

  test 'should create summary' do
    expected_a = [0] + [ 10.minutes ] + [ 10.minutes ] + [0] * 10
    expected_b = [0] + [ 10.minutes ] + [0] + [ 10.minutes ] + [0] * 9
    expected_total =
        [0] + [ 20.minutes ] + [ 10.minutes ] + [ 10.minutes ] + [0] * 9

    assert_equal expected_a, @summary['a']
    assert_equal expected_b, @summary['b']
    assert_equal expected_total, @summary['Total']
  end

end
