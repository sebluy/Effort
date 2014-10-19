require 'test_helper'

class BlocksControllerTest < ActionController::TestCase

  test 'should start a new block' do
  
    discipline = disciplines(:coding)
    
    assert_difference('discipline.blocks.count') do
      post :start, discipline_id: discipline
    end
  
    assert_redirected_to discipline_path(discipline)

  end

end
