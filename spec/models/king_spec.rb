require 'rails_helper'

RSpec.describe King, type: :model do
  describe "#valid_move?" do
    let(:game) { FactoryBot.create :game, player_whites_turn: true }
    let(:white_king) { 
      FactoryBot.create :sample_white_king,
      x_position: 3, y_position: 3, game_id: game.id 
    }
    let(:black_king) { 
      FactoryBot.create :sample_black_king,
      x_position: 5, y_position: 8, game_id: game.id 
    }

    it "can move forward one sqaure" do 
      expect(white_king.valid_move?(3,4)).to be true
    end

    it "can move backward one sqaure" do 
      expect(white_king.valid_move?(3,2)).to be true
    end

    it "can move right one sqaure" do 
      expect(white_king.valid_move?(4,3)).to be true
    end

    it "can move left one sqaure" do 
      expect(white_king.valid_move?(2,3)).to be true
    end

    it "can move forward one sqaure and right one square" do 
      expect(white_king.valid_move?(4,4)).to be true
    end

    it "can move forward one sqaure and left one square" do 
      expect(white_king.valid_move?(2,4)).to be true
    end

    it "can move backward one sqaure and right one square" do 
      expect(white_king.valid_move?(4,2)).to be true
    end

    it "can move backward one square and left one square" do 
      expect(white_king.valid_move?(2,2)).to be true
    end

    it "cannot move onto its own piece" do
      friendly_pawn = FactoryBot.create :sample_white_pawn,
             x_position: 2, y_position: 2, game_id: game.id

      expect(white_king.valid_move?(2,2)).to be false
    end

    it "can capture an enemy piece" do
      enemy_pawn = FactoryBot.create :sample_black_pawn,
             x_position: 4, y_position: 4, game_id: game.id

      expect(white_king.valid_move?(4,4)).to be true
    end

    it "cannot move into check" do
      enemy_bishop = FactoryBot.create :sample_black_bishop,
               x_position: 4, y_position: 5, game_id: game.id
      
      expect(white_king.valid_move?(3,4)).to be false
    end

    it "should recognize each of the two color kings"

    context "a white king" do
      it "cannot move into check against a pawn" do
        enemy_pawn = FactoryBot.create :sample_black_pawn,
                x_position: 4, y_position: 5, game_id: game.id
        expect(enemy_pawn.valid_move?(3,4)).to be false
        expect(white_king.valid_move?(3,4)).to be false
      end
    end

    context "a black king" do
      it "cannot move into check against a pawn" do
        enemy_pawn = FactoryBot.create :sample_white_pawn,
                x_position: 7, y_position: 6, game_id: game.id
        expect(enemy_pawn.valid_move?(4,4)).to be false
        expect(black_king.valid_move?(4,4)).to be false
      end
    end
  end
end