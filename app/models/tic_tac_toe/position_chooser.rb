module TicTacToe
  class PositionChooser

    attr_reader :game_board
    attr_reader :raw_board
    attr_reader :player
    attr_reader :opponent

    def initialize(player, board)
      @player = player
      @raw_board = board.clone
      @game_board = TicTacToe::Board.new(board.clone)
    end

    def best_computer_position
      game_board.open_positions[0]
    end

    def player=(player)
      @player = player
      @opponent = opposite_player(player)
    end

    def opposite_player(player)
      player == 'x' ? 'o' : 'x'
    end

    def bob
      positions = game_board.open_positions
      check_positions(raw_board, player, positions)
    end

    def check_positions(parent_raw_board, board_player, positions, parent_position = nil)
      positions.each do |position|
        position[:player] = board_player
        position[:parent] = parent_position
        new_board = prep_new_game_board(parent_raw_board)
        record_position = converted_position(position)
        new_board.set_position(board_player, record_position)
        if new_board.winner?
          record_position[:state] = player == board_player ? 'winner' : 'looser'
        elsif new_board.closed?
          record_position[:state] = 'closed'
        else
          child_board = prep_new_game_board(new_board.current_board)
          # puts "opposite player: #{opposite_player(player)}"
          # puts "positions: #{child_board.open_positions}"
          # puts "self: #{position}"
          check_positions(child_board.current_board, opposite_player(board_player), child_board.open_positions, record_position)
          record_position[:state] = 'open'
        end
        puts record_position
      end
    end

    def converted_position(position)
      {'row' => position[:row], 'cell' => position[:cell]}
    end

    def prep_new_game_board(board)
      TicTacToe::Board.new(manually_create_board(board))
    end
    #get all open positions for x
    #  set each x and see if it is a winner
    #  if no winner
    #    get all open positions for o
    #    set each o and see if it is a winner
    #    if it is a winner remove that o position
    #

    def manually_create_board(board)
      {
        '0' => [board['0'][0], board['0'][1], board['0'][2] ],
        '1' => [board['1'][0], board['1'][1], board['1'][2] ],
        '2' => [board['2'][0], board['2'][1], board['2'][2] ]
      }
    end
  end
end
