require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe "pieces#index" do
    it "returns a json list of pieces" do
      game = FactoryBot.create(:sample_game)
      game.populate_white_side
      game.populate_black_side
      game.reload

      get :index, params: { game_id: game.id, use_route: game_pieces_path(game) }

      expect(response).to have_http_status(:success)
    end
  end

  describe "pieces#update" do
    it "updates a piece to a new location" do
      white_pawn = FactoryBot.create(:sample_white_pawn)
      game = Game.find(white_pawn.game_id)
      black_king = FactoryBot.create :sample_black_king, game_id: game.id

      game.start

      patch :update, params: { game_id: game.id, id: white_pawn.id, use_route: game_piece_path(game, white_pawn), piece: { x_position: 1, y_position: 2 } }

      expect(response).to have_http_status(:success)
      white_pawn.reload
      expect(white_pawn.y_position).to eq(2)
    end

    it "cannot update a piece off the game board" do
      game = FactoryBot.create(:sample_game)
      white_pawn = FactoryBot.create :sample_white_pawn,
                   x_position: 8, y_position: 8, game_id: game.id

      patch :update, params: { game_id: game.id, id: white_pawn.id, use_route: game_piece_path(game, white_pawn), piece: { x_position: 8, y_position: 9 } }

      white_pawn.reload
      expect(white_pawn.y_position).to eq(8)
    end

    it "updates the board to reflect the check state after a piece is moved" do
      game = FactoryBot.create :sample_game,
            white_player_id: 1, black_player_id: 2
      black_king = game.kings.create(x_position: 3, y_position: 7, game_id: game.id, color: "black")
      white_rook = game.rooks.create(x_position: 2, y_position: 2, game_id: game.id, color: "white")

      game.start
        
      expect(game.state).to eq("In Progress")

      patch :update, params: { game_id: game.id, id: white_rook.id, use_route: game_piece_path(game, white_rook), piece: { x_position: 2, y_position: 7 } }

      game.reload
      expect(game.state).to eq("Check")
    end

    it "tells the players the active player" do
      user_white = FactoryBot.create :user
      user_black = FactoryBot.create :user
      game = FactoryBot.create :sample_game,
      white_player_id: user_white.id, black_player_id: user_black.id
      game.populate_white_side
      game.populate_black_side
      game.start

      white_pawn_1 = game.pawns.find_by(x_position: 6, y_position: 2)
      white_pawn_2 = game.pawns.find_by(x_position: 7, y_position: 2)
      white_king   = game.kings.find_by(color: "white")

      black_pawn   = game.pawns.find_by(x_position: 5, y_position: 7)
      black_queen  = game.queens.find_by(color: "black")

      patch :update, params: {
        game_id: game.id, id: white_pawn_1.id, use_route: game_piece_path(game, white_pawn_1), piece: {
          x_position: 6, y_position: 3
        }
      }
      game_response = JSON.parse(response.body)
      expect(game_response["state"]).to eq "In Progress"
      expect(game_response["active_color"]).to eq "black"
    end
  end
end