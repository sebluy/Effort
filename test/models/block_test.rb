require 'test_helper'

class BlockTest < ActiveSupport::TestCase

  test 'should calculate time spent correctly' do
    assert_equal 60, blocks(:one).time_spent
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

end
