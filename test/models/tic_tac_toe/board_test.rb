require 'test_helper'

class BoardTest < ActiveSupport::TestCase

  def setup
    @board = TicTacToe::Board.new(starting_board)
  end

  # TODO update board tests to test new methods

  test 'starting board rows' do
    board = TicTacToe::Board::STARTING_BOARD
    assert_equal(3, board.keys.count)
    assert_equal('0', board.keys[0])
    assert_equal('1', board.keys[1])
    assert_equal('2', board.keys[2])
  end

  test 'starting board cells' do
    board = TicTacToe::Board::STARTING_BOARD
    board.each do |row, cells|
      assert_equal(3, cells.count)
      cells.each do |cell|
        assert_equal(TicTacToe::Board::OPEN_POSITION, cell)
      end
    end
  end

  test 'open position' do
    assert_equal('0', TicTacToe::Board::OPEN_POSITION)
  end

  # test 'initialize with no param' do
  #   board = TicTacToe::Board.new
  #   assert(board.current_board, 'current_board was not populated')
  # end

  test 'initialize passsing in board' do
    my_board = 'board'
    board = TicTacToe::Board.new(my_board)
    assert_equal(my_board, board.current_board)
  end

  test 'set position' do
    position = {'row' => '0', 'cell' => '0'}
    @board.set_position('x', position)
    assert_equal('x', @board.current_board['0'][0])
  end

  test 'positions by state open' do
    positions = @board.positions_by_state(TicTacToe::Board::OPEN_POSITION)
    assert_equal(9, positions.count)
  end

  test 'positions by state x' do
    @board.current_board['0'][0] = 'x'
    positions = @board.positions_by_state('x')
    assert_equal(1, positions.count)
  end

  test 'all open positions' do
    positions = @board.open_positions
    assert_equal(9, positions.count)
  end

  test 'partial open positions' do
    @board.set_position('x', {'row' => '0', 'cell' => '0'})
    @board.set_position('o', {'row' => '1', 'cell' => '0'})
    @board.set_position('x', {'row' => '2', 'cell' => '0'})
    positions = @board.open_positions
    assert_equal(6, positions.count)
  end

  test 'position open true' do
    position = {'row' => '0', 'cell' => '0'}
    assert_equal(true, @board.position_open(position))
  end

  test 'position open false' do
    position = {'row' => '0', 'cell' => '0'}
    @board.set_position('x', position)
    assert_equal(false, @board.position_open(position))
  end

  test 'closed? false' do
    assert_equal(false, @board.closed?)
  end

  test 'closed? no more moves' do
    closed_board = {
      '0' => ['x','o','o'],
      '1' => ['o','x','x'],
      '2' => ['x','o','0']
    }
    board = TicTacToe::Board.new(closed_board)
    assert_equal(true, board.closed?)
  end

  test 'closed? won x' do
    closed_board = {
      '0' => ['x','o','o'],
      '1' => ['x','0','0'],
      '2' => ['x','0','0']
    }
    board = TicTacToe::Board.new(closed_board)
    assert_equal(true, board.closed?)
  end

  test 'closed? won o' do
    closed_board = {
      '0' => ['o','o','o'],
      '1' => ['x','x','0'],
      '2' => ['x','0','0']
    }
    board = TicTacToe::Board.new(closed_board)
    assert_equal(true, board.closed?)
  end

  test 'positions for player' do
    @board.set_position('x', {'row' => '0', 'cell' => '0'})
    @board.set_position('x', {'row' => '1', 'cell' => '0'})
    @board.set_position('x', {'row' => '2', 'cell' => '0'})

    positions = @board.positions_for_player('x')
    assert_equal(3, positions.count)
    positions.each do |position|
      row = position[:row]
      cell = position[:cell].to_i
      assert_equal('x', @board.current_board[row][cell])
    end
  end

  test 'winner accross row 0' do
    winning_board = {
      '0' => ['o','o','o'],
      '1' => ['x','x','0'],
      '2' => ['x','0','0']
    }
    board = TicTacToe::Board.new(winning_board)
    assert_equal(true, board.winner_across?)
    assert(board.winner.present?)
    assert_equal('o', board.winner['player'])
    assert_equal('across', board.winner['direction'])
  end

  test 'winner accross row 1' do
    winning_board = {
      '0' => ['o','o','0'],
      '1' => ['x','x','x'],
      '2' => ['x','0','0']
    }
    board = TicTacToe::Board.new(winning_board)
    assert_equal(true, board.winner_across?)
    assert(board.winner.present?)
    assert_equal('x', board.winner['player'])
    assert_equal('across', board.winner['direction'])
  end

  test 'winner accross row 2' do
    winning_board = {
      '0' => ['o','o','0'],
      '1' => ['x','0','0'],
      '2' => ['x','x','x']
    }
    board = TicTacToe::Board.new(winning_board)
    assert_equal(true, board.winner_across?)
    assert(board.winner.present?)
    assert_equal('x', board.winner['player'])
    assert_equal('across', board.winner['direction'])
  end

  test 'winner down cell 0' do
    winning_board = {
      '0' => ['x','o','o'],
      '1' => ['x','0','0'],
      '2' => ['x','0','0']
    }
    board = TicTacToe::Board.new(winning_board)
    assert_equal(true, board.winner_down?)
    assert(board.winner.present?)
    assert_equal('x', board.winner['player'])
    assert_equal('down', board.winner['direction'])
  end

  test 'winner down cell 1' do
    winning_board = {
      '0' => ['0','o','o'],
      '1' => ['x','o','x'],
      '2' => ['x','o','x']
    }
    board = TicTacToe::Board.new(winning_board)
    assert_equal(true, board.winner_down?)
    assert(board.winner.present?)
    assert_equal('o', board.winner['player'])
    assert_equal('down', board.winner['direction'])
  end

  test 'winner down cell 2' do
    winning_board = {
      '0' => ['0','x','o'],
      '1' => ['x','0','o'],
      '2' => ['x','0','o']
    }
    board = TicTacToe::Board.new(winning_board)
    assert_equal(true, board.winner_down?)
    assert(board.winner.present?)
    assert_equal('o', board.winner['player'])
    assert_equal('down', board.winner['direction'])
  end

  test 'winner diaginal right' do
    winning_board = {
      '0' => ['o','x','0'],
      '1' => ['x','o','o'],
      '2' => ['x','0','o']
    }
    board = TicTacToe::Board.new(winning_board)
    assert_equal(true, board.winner_diaginal?)
    assert(board.winner.present?)
    assert_equal('o', board.winner['player'])
    assert_equal('diagnal_right', board.winner['direction'])
  end

  test 'winner diaginal left' do
    winning_board = {
      '0' => ['0','o','x'],
      '1' => ['x','x','o'],
      '2' => ['x','0','o']
    }
    board = TicTacToe::Board.new(winning_board)
    assert_equal(true, board.winner_diaginal?)
    assert(board.winner.present?)
    assert_equal('x', board.winner['player'])
    assert_equal('diagnal_left', board.winner['direction'])
  end

   test 'winner? accross' do
     winning_board = {
       '0' => ['o','o','o'],
       '1' => ['x','x','0'],
       '2' => ['x','0','0']
     }
     board = TicTacToe::Board.new(winning_board)
     assert_equal(true, board.winner?)
   end

  test 'winner? down' do
    winning_board = {
      '0' => ['0','x','o'],
      '1' => ['x','0','o'],
      '2' => ['x','0','o']
    }
    board = TicTacToe::Board.new(winning_board)
    assert_equal(true, board.winner?)
  end

  test 'winner? diaginal' do
    winning_board = {
      '0' => ['0','o','x'],
      '1' => ['x','x','o'],
      '2' => ['x','0','o']
    }
    board = TicTacToe::Board.new(winning_board)
    assert_equal(true, board.winner?)
  end

  def starting_board
    {
      '0' => ['0','0','0'],
      '1' => ['0','0','0'],
      '2' => ['0','0','0']
    }
  end

end
