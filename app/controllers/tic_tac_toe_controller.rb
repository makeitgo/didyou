class TicTacToeController < ApplicationController
  def index
  end

  def turn
    turn_data = params.clone
    game = TicTacToe::Game.new(TicTacToe::Board.new(turn_data['game_board']))
    if game.player_move(turn_data['dave_player'])
      turn_data['hal_player'] = game.computer_move(turn_data['hal_player'])
      turn_data['game_board'] = game.game_board.current_board
      turn_data['result']['valid'] = true
    else
      turn_data['result']['valid'] = false
    end

    puts '@' * 20
    puts turn_data.to_json
    puts '@' * 20

    render json: turn_data.to_json
  end

  private

  def update_result(game, turn_data)
    turn_data['result']['winner'] = game.winner
    turn_data['result']['game_over'] = game.game_over
  end
end
