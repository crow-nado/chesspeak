require 'rails_helper'

RSpec.describe BoardState, type: :model do
  describe "check scenarios" do
    let!(:user1){FactoryBot.create(:user)}
    let!(:user2){FactoryBot.create(:user)}

    it "check in one move" do
      game = FactoryBot.create :black_check_in_one_move,
              white_player_id: user1.id, black_player_id: user2.id
      black_king = game.kings.create(x_position: 3, y_position: 7, game_id: game.id, color: "black")
      white_rook = game.rooks.create(x_position: 2, y_position: 2, game_id: game.id, color: "white")
      board_state = BoardState.new(game)

      expect(board_state.in_check?(black_king)).to be false

      white_rook.update_attributes(y_position: 7)

      expect(board_state.in_check?(black_king)).to be true
    end
  end
end