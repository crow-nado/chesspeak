require 'rails_helper'

RSpec.describe Queen, type: :model do
  describe "#valid_move?" do
    it "can move forward any amount of times on the board" do 
      queen = FactoryBot.create :sample_white_queen
      7.times do |y|
        expect(queen.valid_move?(4,y+1)).to be true
      end
    end
    it "can move backward any amount of times on the board" do 
      queen = FactoryBot.create :sample_black_queen
      7.times do |y|
        expect(queen.valid_move?(4,6-y)).to be true
      end
    end
    it "can move to the right any amount of times on the board" do 
      queen = FactoryBot.create :sample_white_queen, x_position: 0
      7.times do |x|
        expect(queen.valid_move?(x+1,0)).to be true
      end
    end
    it "can move to the left any amount of times on the board" do 
      queen = FactoryBot.create :sample_black_queen, x_position: 7
      7.times do |x|
        expect(queen.valid_move?(6-x,7)).to be true
      end
    end
    it "can move on a diagonal path" do
      queen = FactoryBot.create :sample_white_queen,
               x_position: 3, y_position: 3

      3.times do |n|
        expect(queen.valid_move?(4+n, 4+n)).to be true
        expect(queen.valid_move?(4+n, 2-n)).to be true
        expect(queen.valid_move?(2-n, 4+n)).to be true
        expect(queen.valid_move?(2-n, 2-n)).to be true
      end
    end

    it "can not move through its own piece" do
      game = Game.create()
      queen = FactoryBot.create :sample_white_queen, game_id: game.id
      pawn = FactoryBot.create :sample_white_pawn,
             x_position: 4, y_position: 3, game_id: game.id

      expect(queen.valid_move?(4,2)).to be true
      expect(queen.valid_move?(4,5)).to be false

      game2 = Game.create()
      queen = FactoryBot.create :sample_white_queen, game_id: game2.id
      pawn = FactoryBot.create :sample_white_pawn,
             x_position: 6, y_position: 0, game_id: game2.id

      expect(queen.valid_move?(5,0)).to be true
      expect(queen.valid_move?(6,0)).to be false
    end
    it "can capture an enemy piece, but not continue" do
      game = Game.create()
      queen = FactoryBot.create :sample_white_queen, game_id: game.id
      pawn = FactoryBot.create :sample_black_pawn,
             x_position: 4, y_position: 5, game_id: game.id

      expect(queen.valid_move?(4,5)).to be true
      expect(queen.valid_move?(4,7)).to be false

      game2 = Game.create()
      queen = FactoryBot.create :sample_white_queen, game_id: game2.id
      pawn = FactoryBot.create :sample_black_pawn,
             x_position: 6, y_position: 0, game_id: game2.id

      expect(queen.valid_move?(6,0)).to be true
      expect(queen.valid_move?(7,0)).to be false
    end
  end

end
