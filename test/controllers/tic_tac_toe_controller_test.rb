require 'test_helper'

class TicTacToeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get turn" do
    get :turn
    assert_response :success
  end

end
