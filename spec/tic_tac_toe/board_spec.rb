require 'spec_helper'
require 'tic_tac_toe/board'

describe TicTacToe::Board do

  it "starts with an empty Board" do
    expect(subject.squares).to all(be_empty)
  end

  describe "[] accessor" do
    let(:location) { described_class::LOCATIONS.first }
    let(:player) { 'X' }

    it { is_expected.to respond_to(:[]) }
    it { is_expected.to respond_to(:[]=) }

    it "assigns to a location" do
      subject[location] = player
      expect(subject[location]).to eq player
    end
  end

  describe "#==" do
    let(:moves) do
      [{player: 'X', location: 'B2'}, {player: 'O', location: 'B3'}]
    end
    let(:other_board) { described_class.new }

    before { moves.each { |mov| subject[mov[:location]] = mov[:player] } }

    context "when the same moves have been made" do

      before { moves.each { |mov| other_board[mov[:location]] = mov[:player] } }

      it { is_expected.to eq(other_board) }
    end

    context "when there are different players occupying each square" do
      let(:other_moves) do
        [{player: 'X', location: 'A2'}, {player: 'O', location: 'B3'}]
      end

      before do
        other_moves.each { |mov| other_board[mov[:location]] = mov[:player] }
      end

      it { is_expected.not_to eq(other_board) }
    end
  end

  describe "#valid_location?" do
    it "validates any location" do
      described_class::LOCATIONS.each do |loc|
        expect(described_class.valid_location?(loc)).to be true
      end
    end

    it "reports invalid locations" do
      expect(described_class.valid_location?("FOO")).to be false
    end
  end

  describe "#full?" do
    specify "a new board is not full" do
      expect(subject.full?).to be false
    end

    context "once all locations are filled" do
      let(:player) { 'X' }

      before do
        described_class::LOCATIONS.each do |loc|
          subject[loc] = player
        end
      end

      it { is_expected.to be_full }
    end
  end
end
