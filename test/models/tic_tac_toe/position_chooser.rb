require 'test_helper'

class PositionChooserTest < ActiveSupport::TestCase

  test 'one' do
    board = {'0' => ['0','o','0'], '1' => ['x','x','o'], '2' => ['x','0','o']}

    pc = TicTacToe::PositionChooser.new(player, board)
    pc.bob
  end
end
