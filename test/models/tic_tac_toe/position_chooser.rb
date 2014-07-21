require 'test_helper'

class PositionChooserTest < ActiveSupport::TestCase


  # TODO finish tessting PositionChooser functionality

  test 'one' do
    board = {'0' => ['0','o','0'], '1' => ['x','x','o'], '2' => ['x','0','o']}

    pc = TicTacToe::PositionChooser.new(player, board)

  end
end
