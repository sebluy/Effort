require 'test_helper'

class BlocksControllerTest < ActionController::TestCase

  test 'should start a new block' do
  
    discipline = Discipline.create
    
    assert_difference('discipline.blocks.count', 1) do
      post :start, discipline_id: discipline
    end
  
    assert_redirected_to discipline_path(discipline)

  end

  test 'should finish a block' do

    block = Discipline.create.blocks.create

    post :finish, id: block.id, discipline_id: block.discipline_id
  
    assert_not_nil block.reload.finish
    assert_redirected_to discipline_path(block.discipline_id)
    
  end

  test 'should edit a block' do

    skip

    block = Discipline.create.blocks.create
  
    get :edit, id: block.id, discipline_id: block.discipline_id
  
    assert_equal block, assigns(:block)   
  
  end

  test 'should update a block' do
  
    block = Discipline.create.blocks.create
    
    updated_start = Time.new(2014, 1, 1)
    updated_finish = Time.new(2014, 1, 2)

    patch :update, id: block.id, discipline_id: block.discipline_id,
      block: { id: block.id, discipline_id: block.discipline_id, 
        start: updated_start, finish: updated_finish }
  
    block.reload

    assert_equal updated_start, block.start
    assert_equal updated_finish, block.finish
    
    assert_redirected_to discipline_path(block.discipline_id)

  end

  test 'should destroy a block' do
    
    block = Discipline.create.blocks.create

    assert_difference('Block.count', -1) do
      delete :destroy, id: block.id, discipline_id: block.discipline_id
    end

    assert_redirected_to discipline_path(block.discipline_id)

  end

end
