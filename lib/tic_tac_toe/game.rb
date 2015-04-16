require 'yaml'
require 'tic_tac_toe/board'

module TicTacToe
  class Game
    class InvalidPlayerError < StandardError; end
    class GameOverError < RuntimeError; end

    PLAYERS = %w(X O)

    attr_reader :move_count
    attr_reader :board
    attr_reader :win_paths

    def initialize( moves = nil )
      @move_count = 0
      @board = Board.new
      make_moves(moves) if moves
      @win_paths = load_wins
    end

    def make_move(player:, location:)
      raise InvalidPlayerError unless valid_player?(player)
      raise GameOverError if won? || @board.full?

      @board[location] = player
      @move_count += 1
    end

    def next_player
      PLAYERS[@move_count % 2]
    end

    def won?
      @move_count > 4 && paths_won.count > 0
    end

    def paths_won
      win_paths.select do |path|
        plays = path.map{ |loc| @board[loc] }
        PLAYERS.any? { |player| plays.count(player) == path.count }
      end
    end

    private

    def load_wins
      win_file = '../../config/wins.yml'
      file = File.join(__dir__, win_file)
      YAML::load_file(file) if File.exists?(file)
    end

    def valid_player?(player)
      PLAYERS.include?(player) && player == next_player
    end

    def make_moves(moves)
      moves.each do |move|
        make_move(player: move[:player], location: move[:location])
      end
    end
  end
end
