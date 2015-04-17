require 'spec_helper'
require 'tic_tac_toe/square'

describe TicTacToe::Square do

  it "defaults to an empty value" do
    expect(subject).to be_empty
  end

  describe "#fill(player)" do
    let(:player) { 'X' }

    before { subject.fill(player) }

    it "is no longer empty" do
      expect(subject).not_to be_empty
    end

    it "updates the value of the square" do
      expect(subject.player).to eq player
    end

    it "raises an error if already occupied" do
      expect{
        subject.fill(player)
      }.to raise_error(TicTacToe::Square::AlreadyOccupiedError)
    end
  end

  describe "#==" do
    let(:player) { 'X' }
    let(:other_square) { described_class.new }

    context "when the same player occupies both squares" do
      before do
        subject.fill(player)
        other_square.fill(player)
      end

      it { is_expected.to eq(other_square) }
    end

    context "when there are different players occupying each square" do
      let(:other_player) { 'O' }

      before do
        subject.fill(player)
        other_square.fill(other_player)
      end

      it { is_expected.not_to eq(other_square) }
    end
  end
end
