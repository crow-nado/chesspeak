require 'rails_helper'

RSpec.describe BoardState, type: :model do
  describe "check scenarios" do
    let!(:user1){FactoryBot.create(:user)}
    let!(:user2){FactoryBot.create(:user)}

    context "active player in check" do
      it "allows a player to move out of check" do
        game = FactoryBot.create :sample_game,
               white_player_id: user1.id, black_player_id: user2.id
        black_king = game.kings.create(x_position: 3, y_position: 7, game_id: game.id, color: "black")
        white_rook = game.rooks.create(x_position: 3, y_position: 2, game_id: game.id, color: "white")

        expect(BoardState.in_check?(game, black_king)).to be true

        black_king.update_attributes(x_position: 2)

        expect(BoardState.in_check?(game, black_king)).to be false
      end
      it "requires a player move out of check" do
        game = FactoryBot.create :sample_game,
                white_player_id: user1.id, black_player_id: user2.id
        black_king = game.kings.create(x_position: 3, y_position: 7, game_id: game.id, color: "black")
        white_rook = game.rooks.create(x_position: 3, y_position: 2, game_id: game.id, color: "white")
        
        expect(BoardState.in_check?(game, black_king)).to be true
        puts black_king.valid_moves
        expect(black_king.valid_move?(3,6)).to be false
      end
    end
    context "check in one move" do
      it "allows a player put an opponent in check" do
        game = FactoryBot.create :sample_game,
                white_player_id: user1.id, black_player_id: user2.id
        black_king = game.kings.create(x_position: 3, y_position: 7, game_id: game.id, color: "black")
        white_rook = game.rooks.create(x_position: 2, y_position: 2, game_id: game.id, color: "white")
        
        expect(BoardState.in_check?(game, black_king)).to be false

        white_rook.update_attributes(y_position: 7)

        expect(BoardState.in_check?(game, black_king)).to be true
      end
    end
  end
end