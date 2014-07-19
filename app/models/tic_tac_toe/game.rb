class TicTacToe::Game

  attr_accessor :game_board

  def initialize(board)
    @game_board = board
  end

  def player_move(player, position)
    if valid_move?(player, position)
      game_board.make_move(player, position)
    end
  end


  def game_over?
    game_board.closed?
  end

  def players_move?(player)
    return false if game_over?
    return true if  player == :x && move_difference == 0
    return true if  player == :o && move_difference == 1
    false
  end

  def move_difference
    x = game_board.positions_by_player(:x)
    o = game_board.positions_by_player(:o)
    (x.count - o.count)
  end

  def valid_move?(playher, position)
    players_move?(player) && game_board.position_open(position)
  end

end
