require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "#is_white_piece?" do
    it "checks if the piece is white" do
      white_piece = FactoryBot.create :sample_white_pawn
      black_piece = FactoryBot.create :sample_black_pawn
      expect(white_piece.is_white_piece?).to be true
      expect(black_piece.is_white_piece?).to be false
    end
  end

  describe "#first_move?" do
    it "checks if the piece has been moved" do
      piece = FactoryBot.create :sample_black_pawn
      expect(piece.first_move?).to be true

      piece.update_attributes(x_position: 2)
      expect(piece.first_move?).to be false
    end
  end

  describe "#valid_move" do
    fit "does not allow a piece to move off of the board" do
      game = FactoryBot.create :sample_game
      # piece = game.pieces.create(x_position: 0, y_position: 0)
      white_pawn = FactoryBot.create :sample_white_pawn,
                  x_position: 7, y_position: 7, game_id: game.id
      expect(white_pawn.valid_move?(7, 8)).to be false
    end
  end
end
