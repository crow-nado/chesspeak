require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe "valid_move?" do 
    it "can move forward in an L shaped pattern" do
	    knight = FactoryBot.create :sample_white_knight,
		           x_position: 5, y_position: 5
	    expect(knight.valid_move?(4,7)).to be true
	    expect(knight.valid_move?(6,7)).to be true 
    end
    it "can move backward in an L shaped pattern" do
	    knight = FactoryBot.create :sample_white_knight,
		           x_position: 5, y_position: 5
	    expect(knight.valid_move?(4,3)).to be true
	    expect(knight.valid_move?(6,3)).to be true 
    end
    it "can move right in an L shaped pattern" do
	    knight = FactoryBot.create :sample_black_knight,
		           x_position: 5, y_position: 5
	    expect(knight.valid_move?(7,4)).to be true
	    expect(knight.valid_move?(7,6)).to be true 
    end
    it "can move left in an L shaped pattern" do
	    knight = FactoryBot.create :sample_black_knight,
		           x_position: 5, y_position: 5
	    expect(knight.valid_move?(3,4)).to be true
	    expect(knight.valid_move?(3,6)).to be true 
    end
    it "cannot move onto its own piece" do
	    game = Game.create()
	    pawn = FactoryBot.create :sample_white_pawn,
		    x_position: 3, y_position: 4, game_id: game.id
	    knight = FactoryBot.create :sample_white_knight,
		    x_position: 2, y_position: 2, game_id: game.id
	    expect(knight.valid_move?(3,4)).to be false
	    expect(knight.valid_move?(1,4)).to be true
    end
    it "can move onto enemy pieces" do
	    game = Game.create() 
      pawn = FactoryBot.create :sample_white_pawn,
		    x_position: 3, y_position: 4, game_id: game.id
	    knight = FactoryBot.create :sample_black_knight,
		    x_position: 2, y_position: 2, game_id: game.id
	    expect(knight.valid_move?(3,4)).to be true
	    expect(knight.valid_move?(1,4)).to be true
    end
  end
end
