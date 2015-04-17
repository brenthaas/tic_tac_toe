module TicTacToe
  class Square
    class AlreadyOccupiedError < RuntimeError; end

    attr_reader :player

    def empty?
      @player.nil?
    end

    def fill(player)
      raise TicTacToe::Square::AlreadyOccupiedError unless empty?
      @player = player
    end
  end
end
