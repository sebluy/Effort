require 'test_helper'

class DisciplinesControllerTest < ActionController::TestCase

  test 'should show the index' do

    # offset by 3 days to help assert order is by week
    reference = Time.zone.today - 3.days

    # make first block shorter
    Discipline.create.blocks.create(
      start: reference - 10.seconds,
      finish: reference
    )
    Discipline.create.blocks.create(
      start: reference - 20.seconds,
      finish: reference
    )
  
    get :index

    disciplines = assigns(:disciplines)
    weekly_time_first = disciplines[0].time_spent(:week).length
    weekly_time_second = disciplines[1].time_spent(:week).length

    # should reorder to make the first block longer
    assert weekly_time_first >= weekly_time_second

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

end
