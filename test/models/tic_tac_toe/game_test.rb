require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def setup
    @board = TicTacToe::Board.new(starting_board)
    @game = TicTacToe::Game.new(@board)
  end

  # TODO Check to make sure all game methods are covered

  test 'player x' do
    assert_equal('x', TicTacToe::Game::PLAYER_X)
  end

  test 'player o' do
    assert_equal('o', TicTacToe::Game::PLAYER_O)
  end

  test 'initialize' do
    assert_equal(@game.game_board.class, TicTacToe::Board)
  end

  test 'player move true' do
    action = {'player' => 'x', 'row' => '0', 'cell' => '0'}
    result = @game.player_move(action)
    assert_equal(true, result)
    player = @game.game_board.current_board['0'][0]
    assert_equal('x', player)
  end

  test 'player move false' do
    action = {'player' => 'x', 'row' => '0', 'cell' => '0'}
    @game.player_move(action)
    result = @game.player_move(action)
    assert_equal(false, result)
  end

  test 'computer move valid' do
    action = {'player' => 'x', 'row' => '0', 'cell' => '0'}
    return_action = @game.computer_move(action)
    assert_equal('0', return_action['row'])
    assert_equal(0, return_action['cell'])
    assert_equal('x', return_action['player'])
  end

  test 'winner winner' do
    winning_board = {
      '0' => ['0','o','x'],
      '1' => ['x','x','o'],
      '2' => ['x','0','o']
    }
    board = TicTacToe::Board.new(winning_board)
    game = TicTacToe::Game.new(board)
    winner = game.winner
    assert_equal('x', winner['player'])
  end

  test 'winner draw' do
    closed_board = {
      '0' => ['x','o','o'],
      '1' => ['o','x','x'],
      '2' => ['x','o','0']
    }
    board = TicTacToe::Board.new(closed_board)
    game = TicTacToe::Game.new(board)
    winner = game.winner
    assert_equal(nil, winner)
  end

  test 'game over draw' do
    closed_board = {
      '0' => ['x','o','o'],
      '1' => ['o','x','x'],
      '2' => ['x','o','0']
    }
    board = TicTacToe::Board.new(closed_board)
    game = TicTacToe::Game.new(board)
    assert_equal(true, game.game_over?)
  end

  test 'game over winner' do
    winning_board = {
      '0' => ['0','o','x'],
      '1' => ['x','x','o'],
      '2' => ['x','0','o']
    }
    board = TicTacToe::Board.new(winning_board)
    game = TicTacToe::Game.new(board)
    assert_equal(true, game.game_over?)
  end

  test 'game over false' do
    assert_equal(false, @game.game_over?)
  end

  test 'players move x yes' do
    board = {
      '0' => ['0','o','x'],
      '1' => ['0','0','0'],
      '2' => ['0','0','0']
    }
    game = TicTacToe::Game.new(TicTacToe::Board.new(board))
    assert_equal(true, game.players_move?('x'))
  end

  test 'players move x no' do
    board = {
      '0' => ['0','o','x'],
      '1' => ['0','0','x'],
      '2' => ['0','0','0']
    }
    game = TicTacToe::Game.new(TicTacToe::Board.new(board))
    assert_equal(false, game.players_move?('x'))
  end

  test 'players move o no' do
    board = {
      '0' => ['0','o','x'],
      '1' => ['0','0','0'],
      '2' => ['0','0','0']
    }
    game = TicTacToe::Game.new(TicTacToe::Board.new(board))
    assert_equal(false, game.players_move?('o'))
  end

  test 'players move o yes' do
    board = {
      '0' => ['0','o','x'],
      '1' => ['0','0','x'],
      '2' => ['0','0','0']
    }
    game = TicTacToe::Game.new(TicTacToe::Board.new(board))
    assert_equal(true, game.players_move?('o'))
  end

  test 'players move winner' do
    winning_board = {
      '0' => ['0','o','x'],
      '1' => ['x','x','o'],
      '2' => ['x','0','o']
    }
    board = TicTacToe::Board.new(winning_board)
    game = TicTacToe::Game.new(board)
    assert_equal(false, game.players_move?('o'))
    assert_equal(false, game.players_move?('x'))
  end

  private

  def starting_board
    {
      '0' => ['0','0','0'],
      '1' => ['0','0','0'],
      '2' => ['0','0','0']
    }
  end

end
