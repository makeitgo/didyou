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
      @opponent = 'o' if player == 'x'
      @opponent = 'x' if player == 'o'
    end

    def bob
      positions = game_board.open_positions
      positions.each do |position|
        new_board = prep_new_game_board
        new_board.set_position(player, converted_position(position))
        puts raw_board
        if new_board.winner?
          puts 'winner'
        elsif new_board.closed?
          puts 'closed'
        else
          puts 'go on'
        end
      end
    end

    def converted_position(position)
      {'row' => position[:row], 'cell' => position[:cell]}
    end

    def prep_new_game_board
      puts "raw board #{raw_board}"
      TicTacToe::Board.new(manually_create_board)
    end
    #get all open positions for x
    #  set each x and see if it is a winner
    #  if no winner
    #    get all open positions for o
    #    set each o and see if it is a winner
    #    if it is a winner remove that o position
    #

    def manually_create_board
      {
        '0' => [raw_board['0'][0], raw_board['0'][1], raw_board['0'][2] ],
        '1' => [raw_board['1'][0], raw_board['1'][1], raw_board['1'][2] ],
        '2' => [raw_board['2'][0], raw_board['2'][1], raw_board['2'][2] ]
      }
    end
  end
end
