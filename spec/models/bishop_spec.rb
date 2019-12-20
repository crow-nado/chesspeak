require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe "#valid_move?" do
    it "can move diagonally one square" do
      bishop = FactoryBot.create :sample_white_bishop,
               x_position: 4, y_position: 4

      expect(bishop.valid_move?(5,5)).to be true
      expect(bishop.valid_move?(3,3)).to be true
      expect(bishop.valid_move?(3,5)).to be true
      expect(bishop.valid_move?(5,3)).to be true
    end

    it "can move on a diagonal path" do
      bishop = FactoryBot.create :sample_white_bishop,
               x_position: 3, y_position: 3

      3.times do |n|
        expect(bishop.valid_move?(4+n, 4+n)).to be true
        expect(bishop.valid_move?(4+n, 2-n)).to be true
        expect(bishop.valid_move?(2-n, 4+n)).to be true
        expect(bishop.valid_move?(2-n, 2-n)).to be true
      end
    end

    it "cannot move through its own piece" do
      game = Game.create()
      bishop = FactoryBot.create :sample_white_bishop,
               x_position: 3, y_position: 3, game_id: game.id
      pawn = FactoryBot.create :sample_white_pawn,
             x_position: 5, y_position: 5, game_id: game.id

      expect(bishop.valid_move?(4,4)).to be true
      expect(bishop.valid_move?(6,6)).to be false
    end

    it "can capture an enemy piece, but not go through it" do 
      game = Game.create()
      bishop = FactoryBot.create :sample_black_bishop,
               x_position: 3, y_position: 3, game_id: game.id
      pawn = FactoryBot.create :sample_white_pawn,
             x_position: 5, y_position: 5, game_id: game.id

      expect(bishop.valid_move?(5,5)).to be true
      expect(bishop.valid_move?(6,6)).to be false
    end
  end

end
