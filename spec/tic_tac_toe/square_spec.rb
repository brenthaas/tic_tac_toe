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
end
