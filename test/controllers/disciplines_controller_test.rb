require 'test_helper'

class DisciplinesControllerTest < ActionController::TestCase
  
  test 'should clean old blocks on index' do
    start = 14.days.ago
    finish = start + 10.minutes
    Block.create(start: start, finish: finish)
    assert_difference 'Block.count', -1 do
      get :index
    end
  end

  test 'should show a discipline' do
    id = Discipline.create.id
    get :show, {'id' => id}
    assert_response :success
    assert_equal id, assigns(:discipline).id
  end

  test 'should create discipline' do

    assert_difference('Discipline.count') do
      post :create, discipline: {title: 'testing'}
    end
    
    assert_redirected_to disciplines_path

  end

  test 'should destroy a discipline' do 
    
    discipline = Discipline.create

    assert_difference('Discipline.count', -1) do
      delete :destroy, id: discipline.id
    end

    assert_redirected_to disciplines_path

  end

end
