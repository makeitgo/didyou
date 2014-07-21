module TicTacToe
  class PositionChooser

    attr_reader :game_board
    attr_reader :raw_board
    attr_reader :player
    attr_reader :opponent
    attr_accessor :available_moves

    def initialize(player, board)
      @available_moves = []
      @player = player
      @raw_board = board.deep_dup
      @game_board = TicTacToe::Board.new(board)
    end

    def best_computer_position_old
      game_board.open_positions[0]
    end

    def player=(player)
      @player = player
      @opponent = opposite_player(player)
    end

    def opposite_player(player)
      player == 'x' ? 'o' : 'x'
    end

    def best_computer_position
      early_position = early_move_strategy
      if early_position.nil?
        available_position = random_available_position
        {'row' => available_position['row'], 'cell' => available_position['cell']}
      else
        early_position
      end
    end

    def early_move_strategy
      if game_board.open_positions.count == 8
        if game_board.position_open(game_board.center_position)
          game_board.center_position
        else
          random_corner
        end
      elsif game_board.open_positions.count == 9
        random_first_move
      end
    end

    def random_first_move
      random = Random.new
      placement = random_position_number(3)
      position = {'row' => '0', 'cell' => '0'}
      if placement == 1
        random_corner
      elsif placement == 2
        random_edge
      else
        game_board.center_position
      end
    end

    def random_edge
      position_number = random_position_number
      game_board.edge(position_number)
    end

    def random_corner
      position_number = random_position_number
      game_board.corner(position_number)
    end

    def random_available_position
      positions = game_board.open_positions
      find_available_moves(raw_board, player, positions)
      position_number = random_position_number(0, available_moves.size)
      position_tree = available_moves[position_number]
      parent_in_position_tree(position_tree)
    end

    def parent_in_position_tree(position_tree)
      return position_tree if position_tree[:parent].nil?
      parent_in_position_tree(position_tree[:parent])
    end

    def random_position_number(start=1, count = 4)
      range = Range.new(start, count)
      random = Random.new
      position_number = random.rand(range)
    end

    def find_available_moves(parent_raw_board, board_player, positions, parent_position = nil)
      positions.each do |position|
        record_position = converted_position(position)
        record_position[:player] = board_player
        record_position[:parent] = parent_position
        record_position[:depth] = parent_position.nil? ? 0 : parent_position[:depth] + 1
        new_board = prep_new_game_board(parent_raw_board)

        new_board.set_position(board_player, record_position)
        if new_board.winner?
          if (player == board_player)
            record_position[:state] = 'winner'
            available_moves << record_position
          end
        elsif new_board.closed?
          record_position[:state] = 'closed'
          available_moves << record_position
        else
          child_board = prep_new_game_board(new_board.current_board)
          # puts "opposite player: #{opposite_player(player)}"
          # puts "positions: #{child_board.open_positions}"
          # puts "self: #{position}"
          find_available_moves(child_board.current_board, opposite_player(board_player), child_board.open_positions, record_position)
          record_position[:state] = 'open'
        end
      end
      available_moves
    end

    def converted_position(position)
      {'row' => position[:row], 'cell' => position[:cell]}
    end

    def prep_new_game_board(board)
      TicTacToe::Board.new(board.deep_dup)
    end
    #get all open positions for x
    #  set each x and see if it is a winner
    #  if no winner
    #    get all open positions for o
    #    set each o and see if it is a winner
    #    if it is a winner remove that o position
    #

  end
end
