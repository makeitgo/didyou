class TicTacToeController < ApplicationController
  def index
  end

  def turn
    # game = TicTacToe::Game.new(TicTacToe::Board.new(params['game_board']))
    dave_player = params['state']['dave_player']
    hal_player = params['state']['hal_player']
    puts '@' * 20
    puts dave_player
    puts hal_player
    puts '@' * 20

    render json: {'me' => 'you', 'fred' => 'merry'}
  end
end
