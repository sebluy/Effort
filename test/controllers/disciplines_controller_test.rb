require 'test_helper'

class DisciplinesControllerTest < ActionController::TestCase

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
