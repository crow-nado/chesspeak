require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "#image" do
    it "sets the pawns image in unicode according to its row" do
      game = Game.create()
      game.populate_white_pawns
      expect(game.pawns.find_by(y_position: 2).image).to eq "&#9817"
    end
  end
end
