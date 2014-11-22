require 'test_helper'

class BlockTest < ActiveSupport::TestCase

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

  test 'should provide a valid time duration' do
    
    duration = Block.create(
      start: Time.new(2014, 1, 1),
      finish: Time.new(2014, 1, 1, 23, 32, 1)
    ).duration

    assert_equal "23:32:01", duration.to_s
    assert_equal 23.hours + 32.minutes + 1.second, duration.length

  end
     
end
