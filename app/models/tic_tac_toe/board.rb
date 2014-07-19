class TicTacToe::Board

  STARTING_BOARD = { 1 => { 1 => :open, 2 => :open, 3 => :open },
    2 => { 1 => :open, 2 => :open, 3 => :open },
    3 => { 1 => :open, 2 => :open, 3 => :open }
  }

  attr_accessor :current_board
  attr_accessor :winner

  def initialize(board = STARTING_BOARD)
    @current_board = board
  end

  def closed?

  end

  def winner?
    check_for_winner_accross if winner.nil?
    check_for_winner_down if winner.nil?
    check_for_winner_diaginal if winner.nil?
    winner.present?
  end

  def check_for_winner_accross
    (1..3).each do |row|
      if current_board[row][1] != :open && current_board[row][2] != :open && current_board[row][3]
        if current_board[row][1] == current_board[row][2] && current_board[row][1] == current_board[row][3]
          self.winner = {row: row, cell: 1, direction: :accross, player: current_board[row][1]}
          break
        end
      end
    end
  end

  def check_for_winner_down
    (1..3).each do |cell|
      if current_board[1][cell] != :open && current_board[2][cell] != :open && current_board[3][cell]
        if current_board[1][cell] == current_board[2][cell] && current_board[1][cell] == current_board[3][cell]
          self.winner = {row: 1, cell: cell, direction: :down, player: current_board[1][cell]}
          break
        end
      end
    end
  end

  def check_for_winner_diaginal
    if current_board[1][1] != :open && current_board[2][2] != :open && current_board[3][3]
      if current_board[1][1] == current_board[2][2] && current_board[1][1] == current_board[3][3]
        self.winner = {row: 1, cell: 1, direction: :diagnal_right, player: current_board[1][1]}
      end
    elsif current_board[1][3] != :open && current_board[2][2] != :open && current_board[3][1]
      if current_board[1][3] == current_board[2][2] && current_board[1][3] == current_board[3][1]
        self.winner = {row: 1, cell: 3, direction: :diagnal_left, player: current_board[1][3]}
      end
    end
  end




end
