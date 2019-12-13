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
end
