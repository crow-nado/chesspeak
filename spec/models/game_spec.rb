require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "#populate_white_pawns" do
    it "places the white pawns in the Game" do
      game = Game.create()
      game.populate_white_pawns
      test_pawn = game.pawns.find_by(y_position: 2)
      expect(test_pawn).to be_instance_of(Pawn)
    end

    it "ties the white_player_id to the white pawns" do
      game = Game.create(white_player_id: 1)
      game.populate_white_pawns
      test_pawn = game.pawns.find_by(y_position: 2)
      expect(test_pawn.player_id).to eq 1
      expect(test_pawn.is_white_piece?).to be true
      expect(test_pawn.image).to eq "&#9817"
    end
  end

  describe "#change_player_turn" do
    it "checks to see whether or not it's the white player's turn" do
      white_player = FactoryBot.create :user
      black_player = FactoryBot.create :user
      game = FactoryBot.create :sample_game, white_player_id: white_player.id,
             black_player_id: black_player.id
      game.start
      expect(game.active_turn_player.id).to be game.white_player_id
      game.change_player_turn
      expect(game.active_turn_player.id).to be game.black_player_id
    end
  end

  describe "#available" do
    it "checks all games and filters out the unavailable ones" do
      game1 = Game.create()
      game2 = Game.create(white_player_id: 1, black_player_id: 2)
      expect(Game.available.count).to eq 1
    end
  end

  describe "#check_square" do
    it "gives the piece at a specific coordinate" do
      game = FactoryBot.create :sample_game
      game.populate_white_pawns
      pawn = game.pieces.first

      expect(game.check_square(pawn.x_position, pawn.y_position)).to be_instance_of(Pawn)
    end
  end
end
