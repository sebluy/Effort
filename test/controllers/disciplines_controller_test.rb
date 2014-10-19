require 'test_helper'

class DisciplinesControllerTest < ActionController::TestCase

  test 'should show the index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:disciplines)
  end

  test 'should show a discipline' do
    id = disciplines(:coding).id
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

end
