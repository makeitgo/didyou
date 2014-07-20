class TicTacToeController < ApplicationController
  def index
  end

  def turn
    puts '@' * 20
    puts params['game_board']
    puts '@' * 20

    render json: {me: 'you'}
  end
end
