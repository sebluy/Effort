require 'test_helper'

class BlockTest < ActiveSupport::TestCase

  test 'should calculate time spent correctly' do
    skip

    start = Time.new(2014, 10, 14, 10, 10, 0)
    finish = Time.new(2014, 10, 14, 10, 10, 1)
    
    block = Block.create(start: start, finish: finish)

    assert_equal 1, block.duration.length

  end

  test 'should start a new block' do

    block = nil

    assert_difference('Block.count') do
      block = Block.start_new
    end
  
    assert_nil block.finish
    assert_nil block.discipline_id
    assert_in_delta Time.now, block.start, 1.second
    
  end

  test 'should finish a block' do
    
    block = Block.create

    block.finish_new
  
    assert_in_delta Time.now, block.finish, 1.second

  end

  test 'should calculate time spent' do

    block = Block.create

    block.start = Time.now - 30.second
  
    assert_in_delta 30.seconds, block.time_spent, 1.second

    block.finish = Time.now
  
    assert_in_delta 30.seconds, block.time_spent, 1.second

  end

  test 'should create correct time spent string' do
    
    skip
    block = Block.create(
      start: Time.new(2014, 1, 1),
      finish: Time.new(2014, 1, 2)
    )

    assert_equal "1 day", block.time_spent_string

  end
     
end
