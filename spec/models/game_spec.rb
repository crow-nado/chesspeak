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

  describe "#available" do
    it "checks all games and filters out the unavailable ones" do
      game1 = Game.create()
      game2 = Game.create(white_player_id: 1, black_player_id: 2)
      expect(Game.available.count).to eq 1
    end
  end
end
