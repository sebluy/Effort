require 'test_helper'

class SummaryTest < ActiveSupport::TestCase

  test 'should find class' do
    assert_nothing_raised do
      summary = Summary.new
    end
  end

end
