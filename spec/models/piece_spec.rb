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

  describe "#valid_move?" do
    it "does not allow a piece to move off of the board" do
      game = FactoryBot.create :sample_game
      white_pawn = FactoryBot.create :sample_white_pawn,
                  x_position: 7, y_position: 7, game_id: game.id
      expect(white_pawn.valid_move?(7, 8)).to be false
    end
  end

  describe "#is_obstructed_vertical?" do
    it "tells whether or not there is another piece between the origin and destination vertically" do
      game = FactoryBot.create :sample_game
      piece1 = game.pieces.create(x_position: 2, y_position: 2)
      piece2 = game.pieces.create(x_position: 2, y_position: 3)

      expect(piece1.is_obstructed_vertical?(2, 4)).to be true
    end

    it "tells whether or not there is another piece between the origin and destination vertically" do
      game = FactoryBot.create :sample_game
      piece1 = game.pieces.create(x_position: 2, y_position: 3)
      piece2 = game.pieces.create(x_position: 2, y_position: 2)

      expect(piece1.is_obstructed_vertical?(2, 1)).to be true
    end
  end

  describe "#is_obstructed_horizontal?" do
    it "tells whether there is another piece between the origin and destination" do
      game = FactoryBot.create :sample_game
      piece1 = game.pieces.create(x_position: 2, y_position: 2)
      piece2 = game.pieces.create(x_position: 3, y_position: 2)
      expect(piece1.is_obstructed_horizontal?(4,2)).to be true
    end

    it "tells whether there is another piece between the origin and destination" do
      game = FactoryBot.create :sample_game
      piece1 = game.pieces.create(x_position: 2, y_position: 2)
      piece2 = game.pieces.create(x_position: 1, y_position: 2)
      expect(piece1.is_obstructed_horizontal?(0,2)).to be true
    end
  end

  describe "#is_obstructed_diagonal?" do
    it "tells whether there is another piece between the origin and destination" do
      game = FactoryBot.create :sample_game
      piece1 = game.pieces.create(x_position: 2, y_position: 2)
      piece2 = game.pieces.create(x_position: 3, y_position: 3)
      expect(piece1.is_obstructed_diagonal?(4,4)).to be true
    end
  end
end
