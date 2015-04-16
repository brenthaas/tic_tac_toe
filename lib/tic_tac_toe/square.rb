module TicTacToe
  class Square
    attr_reader :player

    def empty?
      @player.nil?
    end

    def fill(player)
      raise TicTacToe::Square::AlreadyOccupiedError unless empty?
      @player = player
    end

    class AlreadyOccupiedError < RuntimeError
    end
  end
end
