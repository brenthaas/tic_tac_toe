module TicTacToe
  class Square
    class AlreadyOccupiedError < RuntimeError; end

    attr_reader :player
    attr_accessor :winner

    def to_s
      player.to_s
    end

    def empty?
      player.nil?
    end

    def fill(player)
      raise TicTacToe::Square::AlreadyOccupiedError "Already Filled" unless empty?
      @player = player
    end

    def ==(other_square)
      player == other_square.player
    end
  end
end
