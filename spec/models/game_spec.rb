require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "#populate!" do
    it "populates the game with pieces" do
      game = Game.create()
      game.populate!
      expect(game.pieces.count).to eq 32
    end
  end

  describe "#populate_white_pawns" do
    it "places the white pawns in the Game" do
      game = Game.create()
      game.populate_white_pawns
      expect(game.pawns.find_by(y_position: 2)).to be_instance_of(Pawn)
    end
  end
end
