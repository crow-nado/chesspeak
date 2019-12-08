require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "#is_white_piece?" do
    it "tells a piece its color based on its player_id" do
      game = Game.create(white_player_id: 1, black_player_id: 2)
      white_piece = game.pieces.create(player_id: 1)
      black_piece = game.pieces.create(player_id: 2)
      expect(white_piece.is_white_piece?).to be true
      expect(black_piece.is_white_piece?).to be false
    end
  end
end
