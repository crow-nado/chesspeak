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

  describe "check scenarios" do
    let!(:user1){FactoryBot.create(:user)}
    let!(:user2){FactoryBot.create(:user)}

    it "check in one move" do
      game = FactoryBot.create :black_check_in_one_move,
              white_player_id: user1.id, black_player_id: user2.id
      black_king = game.kings.create(x_position: 3, y_position: 7, game_id: game.id, color: "black")
      white_rook = game.rooks.create(x_position: 2, y_position: 2, game_id: game.id, color: "white")

      white_rook.update_attributes(y_position: 7)

      expect(game.in_check?).to be true
    end
  end
end
