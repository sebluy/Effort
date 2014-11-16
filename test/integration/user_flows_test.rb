require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  
  test 'create a discipline and some blocks' do
    skip
    get '/'
    assert_response :success

    post_via_redirect '/disciplines', discipline: { title: 'test' }
    assert_equal '/disciplines', path
    assert_select 'table', 1

    id = Discipline.first.id
    get "/disciplines/#{id}"
    post_via_redirect "/disciplines/#{id}/blocks/start"
    assert_equal "/disciplines/#{id}", path

    block_id = Block.first.id
    post_via_redirect "/disciplines/#{id}/blocks/#{block_id}/finish"
    assert_equal "/disciplines/#{id}", path

  end

end
