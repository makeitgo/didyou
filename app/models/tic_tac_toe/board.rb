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

  def make_move(player, position)

  end

  def closed?
    open_positions.count <= 1 || winner?
  end

  def open_positions
    positions_by_state(:open)
  end

  def position_open(check_for_position)
    result = false
    positions_by_state.each do |position|
      result = true if position[:row] == check_for_position[:row] &&
        position[:cell] == check_for_position[:cell]
      break if result
    end
    result
  end

  def positions_for_player(player)
    positions_by_state(player)
  end

  def positions_by_state(state)
    positions_in_state = []
    current_board.each do |row_num, cells|
      cells.each do |cell_num, contents|
        positions_in_state << {row: row_num, cell: cell_num} if contents == state
      end
    end
    positions_in_state
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
