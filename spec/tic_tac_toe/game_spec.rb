require 'spec_helper'
require 'tic_tac_toe/game'

describe TicTacToe::Game do

  describe "initial state" do
    specify "move_count is set to 0" do
      expect(subject.move_count).to eq(0)
    end

    specify "the first player starts" do
      expect(subject.next_player).to eq(described_class::PLAYERS.first)
    end

    specify "wins are loaded" do
      expect(subject.win_paths).not_to be_nil
    end

    specify "no winning paths exist" do
      expect(subject.paths_won.count).to eq 0
    end

    specify "it has not been won" do
      expect(subject).not_to be_won
    end
  end

  describe "initialize with moves" do
    let(:moves) do
      [
        { player: 'X', location: 'B1' },
        { player: 'O', location: 'A2' },
        { player: 'X', location: 'B2' },
        { player: 'O', location: 'A3' },
        { player: 'X', location: 'B3' }
      ]
    end

    subject { described_class.new(moves) }

    it "has the right move_count" do
      expect(subject.move_count).to eq moves.count
    end

    it "identifies if the game was won" do
      expect(subject).to be_won
    end
  end

  describe "#make_move" do
    let(:player) { described_class::PLAYERS.first }
    let(:location) { TicTacToe::Board::LOCATIONS.first }

    it "raises an error if an invalid player is used" do
      expect{
        subject.make_move(player: "FOO", location: location)
      }.to raise_error(described_class::InvalidPlayerError)
    end

    it "raises an error if the same player moves twice" do
      subject.make_move(player: player, location: location)
      expect{
        subject.make_move(player: player, location: location)
      }.to raise_error(described_class::InvalidPlayerError)
    end

    it "changes the next player" do
      expect{
        subject.make_move(player: player, location: location)
      }.to change{ subject.next_player }
    end

    it "increments move_count" do
      expect{
        subject.make_move(player: player, location: location)
      }.to change(subject, :move_count).by(1)
    end
  end

  context "when a player has won" do
    let(:winning_moves) { %w(A1 B2 C3) }
    let(:losing_moves) do
      TicTacToe::Board::LOCATIONS.select { |loc| !winning_moves.include?(loc) }
    end

    before do
      winning_moves.count.times do |i|
        subject.make_move(
          player: subject.next_player, location: losing_moves[i]
        )
        subject.make_move(
          player: subject.next_player, location: winning_moves[i]
        )
      end
    end

    it { is_expected.to be_won }

    it "raises a GameOverError for any additional moves" do
      expect{
        subject.make_move(
          player: subject.next_player, location: losing_moves.last
        )
      }.to raise_error
    end
  end
end
