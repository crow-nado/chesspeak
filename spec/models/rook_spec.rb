require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe "#valid_move?" do
    it "can move forward any amount of times on the board" do 
      rook = FactoryBot.create :sample_white_rook
      7.times do |row|
        expect(rook.valid_move?(1,row+2)).to be true
      end
    end
    it "can move backward any amount of times on the board" do 
      rook = FactoryBot.create :sample_black_rook
      7.times do |row|
        expect(rook.valid_move?(8,7-row)).to be true
      end
    end
    it "can move to the right any amount of times on the board" do 
      rook = FactoryBot.create :sample_white_rook
      7.times do |column|
        expect(rook.valid_move?(column+2,1)).to be true
      end
    end
    it "can move to the left any amount of times on the board" do 
      rook = FactoryBot.create :sample_black_rook
      7.times do |column|
        expect(rook.valid_move?(7-column,8)).to be true
      end
    end

    it "can not move through its own piece" do
      game = Game.create()
      rook = FactoryBot.create :sample_white_rook, game_id: game.id
      pawn = FactoryBot.create :sample_white_pawn,
             x_position: 1, y_position: 3, game_id: game.id

      expect(rook.valid_move?(1,2)).to be true
      expect(rook.valid_move?(1,5)).to be false

      game2 = Game.create()
      rook = FactoryBot.create :sample_white_rook, game_id: game2.id
      pawn = FactoryBot.create :sample_white_pawn,
             x_position: 5, y_position: 1, game_id: game2.id

      expect(rook.valid_move?(2,1)).to be true
      expect(rook.valid_move?(6,1)).to be false
    end
    it "can capture an enemy piece, but not continue" do
      game = Game.create()
      rook = FactoryBot.create :sample_white_rook, game_id: game.id
      pawn = FactoryBot.create :sample_black_pawn,
             x_position: 1, y_position: 5, game_id: game.id

      expect(rook.valid_move?(1,5)).to be true
      expect(rook.valid_move?(1,7)).to be false

      game2 = Game.create()
      rook = FactoryBot.create :sample_white_rook, game_id: game2.id
      pawn = FactoryBot.create :sample_black_pawn,
             x_position: 6, y_position: 1, game_id: game2.id

      expect(rook.valid_move?(6,1)).to be true
      expect(rook.valid_move?(7,1)).to be false
    end
  end

end
