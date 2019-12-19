require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe "#valid_move?" do
    it "can move forward any amount of times on the board" do 
      rook = FactoryBot.create :sample_white_rook
      6.times do |row|
        expect(rook.valid_move?(0,row+1)).to be true
      end
    end
    it "can move backward any amount of times on the board" do 
      rook = FactoryBot.create :sample_black_rook
      6.times do |row|
        expect(rook.valid_move?(7,6-row)).to be true
      end
    end
    it "can move to the right any amount of times on the board" do 
      rook = FactoryBot.create :sample_white_rook
      6.times do |column|
        expect(rook.valid_move?(column+1,0)).to be true
      end
    end
    it "can move to the left any amount of times on the board" do 
      rook = FactoryBot.create :sample_black_rook
      6.times do |column|
        expect(rook.valid_move?(6-column,7)).to be true
      end
    end

    it "can not move through its own piece" do
      game = Game.create()
      rook = FactoryBot.create :sample_white_rook, game_id: game.id
      pawn = FactoryBot.create :sample_white_pawn,
             x_position: 0, y_position: 3, game_id: game.id

      expect(rook.valid_move?(0,2)).to be true
      expect(rook.valid_move?(0,5)).to be false

      game2 = Game.create()
      rook = FactoryBot.create :sample_white_rook, game_id: game2.id
      pawn = FactoryBot.create :sample_white_pawn,
             x_position: 5, y_position: 0, game_id: game2.id

      expect(rook.valid_move?(2,0)).to be true
      expect(rook.valid_move?(6,0)).to be false
    end
    it "can capture an enemy piece, but not continue" do
      game = Game.create()
      rook = FactoryBot.create :sample_white_rook, game_id: game.id
      pawn = FactoryBot.create :sample_black_pawn,
             x_position: 0, y_position: 5, game_id: game.id

      expect(rook.valid_move?(0,5)).to be true
      expect(rook.valid_move?(0,7)).to be false

      game2 = Game.create()
      rook = FactoryBot.create :sample_white_rook, game_id: game2.id
      pawn = FactoryBot.create :sample_black_pawn,
             x_position: 6, y_position: 0, game_id: game2.id

      expect(rook.valid_move?(6,0)).to be true
      expect(rook.valid_move?(7,0)).to be false
    end
  end

end
