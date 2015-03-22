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

  test 'daily_time_spend should be accurate for pending blocks' do
    discipline = Discipline.create
    now = Time.zone.now
    discipline.blocks.create(start: now - 10.minutes)
    duration = discipline.daily_time_spent(Date.today)
    assert_in_delta 10.minutes, duration.length, 1.second
  end

  test 'should provide a summary' do
    discipline_a = Discipline.create(title: 'a')
    discipline_b = Discipline.create(title: 'b')
    
    discipline_a.blocks << [ block_at(2.days.ago), block_at(1.day.ago) ]
    discipline_b.blocks << [ block_at(3.days.ago), block_at(1.day.ago) ]
  
    actual_summary = Discipline.summary

    expected_a = [0] + [ 10.minutes ] + [ 10.minutes ] + [0] * 10
    expected_b = [0] + [ 10.minutes ] + [0] + [ 10.minutes ] + [0] * 9
    expected_total =
        [0] + [ 20.minutes ] + [ 10.minutes ] + [ 10.minutes ] + [0] * 9

    assert_equal expected_a, actual_summary['a']
    assert_equal expected_b, actual_summary['b']
    assert_equal expected_total, actual_summary['Total']
  end

  test 'summary should be accurate for pending blocks' do
    discipline = Discipline.create
    now = Time.zone.now
    discipline.blocks.create(start: now - 10.minutes)
    summary = Discipline.summary
    assert_in_delta 10.minutes, summary['Total'][0].length, 1.second
  end

  def block_at(date)
    start = date.beginning_of_day
    finish = start + 10.minutes
    Block.new(start: start, finish: finish)
  end

end
