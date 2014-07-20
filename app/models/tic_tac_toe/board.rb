class TicTacToe::Board

  STARTING_BOARD = { "0" => ["0","0","0"],
    "1" => ["0","0","0"],
    "2" => ["0","0","0"]
  }

  OPEN_POSITION = '0'

  attr_accessor :current_board
  attr_accessor :winner

  def initialize(board = STARTING_BOARD)
    @current_board = board
  end

  def closed?
    open_positions.count <= 1 || winner?
  end

  def open_positions
    positions_by_state(OPEN_POSITION)
  end

  def set_position(player, position)
    current_board[position['row']][position['cell'].to_i] = player
  end

  def position_open(check_for_position)
    result = false
    open_positions.each do |position|
      result = true if position[:row] == check_for_position['row'] &&
        position[:cell] == check_for_position['cell'].to_i
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
      cells.each_with_index do |cell, cell_num |
        positions_in_state << { row: row_num, cell: cell_num } if cell == state
      end
    end
    positions_in_state
  end

  def winner?
    winner_across? || winner_down? || winner_diaginal?
  end

  def winner_across?
    ['0', '1', '2'].each do |row|
      if current_board[row][0] != OPEN_POSITION && current_board[row][0] != OPEN_POSITION && current_board[row][0] != OPEN_POSITION
        if current_board[row][0] == current_board[row][1] && current_board[row][0] == current_board[row][2]
          set_winner('down', current_board[row][0])
          break
        end
      end
    end
    winner.present?
  end

  def winner_down?
    (0..2).each do |cell|
      if current_board['1'][cell] != OPEN_POSITION && current_board['2'][cell] != OPEN_POSITION && current_board['3'][cell] != OPEN_POSITION
        if current_board['1'][cell] == current_board['2'][cell] && current_board['1'][cell] == current_board['3'][cell]
          set_winner('down', current_board['1'][cell])
          break
        end
      end
    end
    winner.present?
  end

  def winner_diaginal?
    if current_board['1'][1] != OPEN_POSITION && current_board['2'][2] != OPEN_POSITION && current_board['3'][3] != OPEN_POSITION
      if current_board['1'][1] == current_board['2'][2] && current_board['1'][1] == current_board['3'][3]
        set_winner('diagnal_right', current_board['1'][1])
      end
    elsif current_board['1'][3] != OPEN_POSITION && current_board['2'][2] != OPEN_POSITION && current_board['3'][1] != OPEN_POSITION
      if current_board['1'][3] == current_board['2'][2] && current_board['1'][3] == current_board['3'][1]
        set_winner('diagnal_left', current_board['1'][3])
      end
    end
    winner.present?
  end

  def set_winner(direction, player)
    self.winner = {'direction' => direction, 'player' => player}
  end



end
