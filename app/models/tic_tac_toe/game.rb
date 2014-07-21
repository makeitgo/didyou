module TicTacToe
  class Game

    attr_accessor :game_board

    PLAYER_X = 'x'
    PLAYER_O = 'o'

    def initialize(board)
      @game_board = board
    end

    def player_move(action)
      position = {'row' => action['row'], 'cell' => action['cell']}
      player = action['player']
      if valid_move?(player, position)
        game_board.set_position(player, position)
        true
      else
        false
      end
    end

    def computer_move(action)
      position_chooser = TicTacToe::PositionChooser.new(action['player'], game_board.current_board)
      open_position = position_chooser.best_computer_position
      position = {'row' => open_position['row'], 'cell' => open_position['cell']}
      player = action['player']
      return_action = {'player' => player}
      if valid_move?(player, position)

        game_board.set_position(player, position)
        return_action.merge!(position)
      end
      return_action
    end

    def winner
      game_board.winner if game_over?
    end

    def game_over?
      game_board.closed?
    end

    def players_move?(player)
      return false if game_over?
      return true if  player == PLAYER_X && move_difference == 0
      return true if  player == PLAYER_O && move_difference == 1
      false
    end

    private

    def valid_move?(player, position)
      players_move?(player) && game_board.position_open(position)
    end

    def move_difference
      x = game_board.positions_for_player(PLAYER_X)
      o = game_board.positions_for_player(PLAYER_O)
      (x.count - o.count)
    end

  end
end
