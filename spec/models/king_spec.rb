require 'rails_helper'

RSpec.describe King, type: :model do
  describe "#valid_move?" do
    it "can move forward one sqaure" do 
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3
      expect(king.valid_move?(3,4)).to be true
    end
    it "can move backward one sqaure" do 
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3
      expect(king.valid_move?(3,2)).to be true
    end
    it "can move right one sqaure" do 
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3
      expect(king.valid_move?(4,3)).to be true
    end
    it "can move left one sqaure" do 
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3
      expect(king.valid_move?(2,3)).to be true
    end
    it "can move forward one sqaure and right one square" do 
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3
      expect(king.valid_move?(4,4)).to be true
    end
    it "can move forward one sqaure and left one square" do 
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3
      expect(king.valid_move?(2,4)).to be true
    end
    it "can move backward one sqaure and right one square" do 
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3
      expect(king.valid_move?(4,2)).to be true
    end
    it "can move backward one sqaure and left one square" do 
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3
      expect(king.valid_move?(2,2)).to be true
    end

    it "cannot move onto its own piece" do
      game = Game.create()
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3, game_id: game.id
      pawn = FactoryBot.create :sample_white_pawn,
             x_position: 2, y_position: 2, game_id: game.id

      expect(king.valid_move?(2,2)).to be false
    end

    it "can capture an enemy piece" do
      game = Game.create()
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3, game_id: game.id
      pawn = FactoryBot.create :sample_black_pawn,
             x_position: 4, y_position: 4, game_id: game.id

      expect(king.valid_move?(4,4)).to be true
    end
    it "cannot move into check" do
      game = Game.create()
      king = FactoryBot.create :sample_white_king,
             x_position: 3, y_position: 3, game_id: game.id
      bishop = FactoryBot.create :sample_black_bishop,
               x_position: 4, y_position: 5, game_id: game.id
      expect(bishop.valid_move?(3,4)).to be true
      expect(king.valid_move?(3,4)).to be false
      expect(king.x_position).to eq 3
      expect(king.y_position).to eq 3
      expect(game.state).not_to eq "Check"
    end
  end
end