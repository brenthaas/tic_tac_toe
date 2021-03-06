require 'tic_tac_toe/square'

module TicTacToe
  class Board
    class InvalidLocationError < StandardError; end

    LOCATIONS = %w(A1 A2 A3 B1 B2 B3 C1 C2 C3)

    attr_reader :squares

    def initialize()
      @squares = LOCATIONS.map { TicTacToe::Square.new }
    end

    def [](location)
      unless self.class.valid_location?(location)
        raise InvalidLocationError.new, "#{location} does not exist"
      end

      @squares[LOCATIONS.index(location)]
    end

    def []=(location, player)
      unless self.class.valid_location?(location)
        raise InvalidLocationError.new, "#{location} does not exist"
      end

      index = LOCATIONS.index(location)
      @squares[index].fill(player)
    end

    def ==(other_board)
      LOCATIONS.all? do |loc|
        self[loc] == other_board[loc]
      end
    end

    def full?
      @squares.none? { |square| square.empty? }
    end

    def self.valid_location?(location)
      LOCATIONS.include? location
    end
  end
end
