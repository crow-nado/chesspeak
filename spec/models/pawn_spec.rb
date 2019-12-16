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
        game = FactoryBot.create(:sample_game)
        white_pawn = FactoryBot.create :sample_white_pawn,
                        x_position: 3, y_position: 3, game_id: game.id
        black_pawn = FactoryBot.create :sample_black_pawn,
                        x_position: 4, y_position: 4, game_id: game.id
        expect(white_pawn.valid_move?(black_pawn.x_position, black_pawn.y_position)).to be true
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
        game = FactoryBot.create(:sample_game)
        black_pawn = FactoryBot.create :sample_black_pawn,
                       x_position: 3, y_position: 3, game_id: game.id
        white_pawn = FactoryBot.create :sample_white_pawn,
                       x_position: 2, y_position: 2, game_id: game.id

        expect(black_pawn.valid_move?(2,2)).to be true
      end
    end
  end


  describe "#add_enemy_diagonal" do
    context "white piece" do
      it "should update valid_moves with a diagonal square occupied by an enemy" do
        game = FactoryBot.create(:sample_game)
        white_pawn = FactoryBot.create :sample_white_pawn,
                    x_position: 3, y_position: 3, game_id: game.id
        black_pawn = FactoryBot.create :sample_black_pawn,
                    x_position: 4, y_position: 4, game_id: game.id
        black_pawn2 = FactoryBot.create :sample_black_pawn,
                    x_position: 2, y_position: 4, game_id: game.id        
        expect(white_pawn.valid_moves).to include({ x: 4, y: 4 })
        expect(white_pawn.valid_moves).to include({ x: 2, y: 4 }) 
      end
      it "should not update valid_moves with a diagonal square occupied by yourself" do
        game = FactoryBot.create(:sample_game)
        white_pawn = FactoryBot.create :sample_white_pawn,
                    x_position: 3, y_position: 3, game_id: game.id
        white_pawn2 = FactoryBot.create :sample_white_pawn,
                    x_position: 4, y_position: 4, game_id: game.id        
        expect(white_pawn.valid_moves).not_to include({ x: 4, y: 4 })
      end
      it "should not update valid_moves with an unoccupied diagonal square" do
        game = FactoryBot.create(:sample_game)
        white_pawn = FactoryBot.create :sample_white_pawn,
                    x_position: 3, y_position: 3, game_id: game.id        
        expect(white_pawn.valid_moves).not_to include({ x: 4, y: 4 })
      end
    end
    context "black piece" do
      it "should update valid_moves with a diagonal square occupied by a white pawn" do
        game = FactoryBot.create(:sample_game)
        white_pawn = FactoryBot.create :sample_white_pawn,
                       x_position: 2, y_position: 2, game_id: game.id
        white_pawn = FactoryBot.create :sample_white_pawn,
                       x_position: 4, y_position: 2, game_id: game.id
        black_pawn = FactoryBot.create :sample_black_pawn,
                       x_position: 3, y_position: 3, game_id: game.id        
        expect(black_pawn.valid_moves).to include({ x: 2, y: 2 })
        expect(black_pawn.valid_moves).to include({ x: 4, y: 2 })
      end
      it "should not update valid_moves with a diagonal square occupied by a black pawn" do
        game = FactoryBot.create(:sample_game)
        black_pawn = FactoryBot.create :sample_black_pawn,
                       x_position: 3, y_position: 3, game_id: game.id
        black_pawn2 = FactoryBot.create :sample_black_pawn,
                       x_position: 2, y_position: 2, game_id: game.id        
        expect(black_pawn.valid_moves).not_to include({ x: 2, y: 2 })
      end      
      it "should not update valid_moves with an unoccupied diagonal square" do
        game = FactoryBot.create(:sample_game)
        black_pawn = FactoryBot.create :sample_black_pawn,
                       x_position: 3, y_position: 3, game_id: game.id        
        expect(black_pawn.valid_moves).not_to include({ x: 2, y: 2 })
      end
    end
  end
end
