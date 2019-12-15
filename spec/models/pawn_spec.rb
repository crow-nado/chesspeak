require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "#image" do
    it "sets the pawns image in unicode according to its row" do
      game = Game.create()
      game.populate_white_pawns
      expect(game.pawns.find_by(y_position: 2).image).to eq "&#9817"
    end
  end

  describe "#valid_move?" do
    context "white piece" do
      it "can move forward" do
        white_pawn = FactoryBot.create :sample_white_pawn,
                     x_position: 3, y_position: 3
        expect(white_pawn.valid_move?(3,4)).to be true
      end
      it "cannot move backward" do
        white_pawn = FactoryBot.create :sample_white_pawn,
                     x_position: 3, y_position: 3
        expect(white_pawn.valid_move?(3,2)).to be false
      end

      it "can move forward two spaces the first time it is moved" do
        white_pawn = FactoryBot.create :sample_white_pawn,
                     x_position: 3, y_position: 3
        expect(white_pawn.valid_move?(3,5)).to be true
      end

      it "cannot move forward two spaces after it has been moved" do
        white_pawn = FactoryBot.create :sample_white_pawn,
                     x_position: 3, y_position: 3
        white_pawn.update_attributes({ x_position: 3, y_position: 4})

        expect(white_pawn.valid_move?(3,6)).to be false
      end

      it "can capture a black pawn diagonally" do
        white_pawn = FactoryBot.create :sample_white_pawn,
                     x_position: 3, y_position: 3
        black_pawn = FactoryBot.create :sample_black_pawn,
                     x_position: 4, y_position: 4

        expect(white_pawn.valid_move?(4,4)).to be true
      end

      it "cannot move diagonally if it cannot capture a black pawn" do
        white_pawn = FactoryBot.create :sample_white_pawn,
                     x_position: 3, y_position: 3
        
        expect(white_pawn.valid_move?(4,4)).to be false
      end
    end
    context "black piece" do
      it "can move forward" do
        black_pawn = FactoryBot.create :sample_black_pawn,
                     x_position: 3, y_position: 3
        expect(black_pawn.valid_move?(3,2)).to be true
      end
      it "cannot move backward" do
        black_pawn = FactoryBot.create :sample_black_pawn,
                     x_position: 3, y_position: 3
        expect(black_pawn.valid_move?(3,4)).to be false
      end

      it "can move forward two spaces the first time it is moved" do
        black_pawn = FactoryBot.create :sample_black_pawn,
                     x_position: 3, y_position: 4
        expect(black_pawn.valid_move?(3,2)).to be true
      end

      it "cannot move forward two spaces after it has been moved" do
        black_pawn = FactoryBot.create :sample_black_pawn,
                     x_position: 3, y_position: 4
        black_pawn.update_attributes({ x_position: 3, y_position: 3})

        expect(black_pawn.valid_move?(3,1)).to be false
      end

      it "can capture a white pawn diagonally" do
        black_pawn = FactoryBot.create :sample_black_pawn,
                     x_position: 3, y_position: 3
        white_pawn = FactoryBot.create :sample_white_pawn,
                     x_position: 2, y_position: 2

        expect(black_pawn.valid_move?(2,2)).to be true
      end

      it "cannot move diagonally if it cannot capture a white pawn" do
        black_pawn = FactoryBot.create :sample_black_pawn,
                     x_position: 3, y_position: 3

        expect(black_pawn.valid_move?(2,2)).to be false
      end
    end
  end
end
