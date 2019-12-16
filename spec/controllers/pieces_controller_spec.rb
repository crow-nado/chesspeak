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

      patch :update, params: { game_id: game.id, id: white_pawn.id, use_route: game_piece_path(game, white_pawn), piece: { x_position: 1, y_position: 2 } }

      expect(response).to have_http_status(:success)
      white_pawn.reload
      expect(white_pawn.y_position).to eq(2)
    end
  end

  describe "pieces#destroy" do
    it "removes a captured piece" do
      white_pawn = FactoryBot.create(:sample_white_pawn)
      game = Game.find(white_pawn.game_id)

      delete :destroy, params: { game_id: game.id, id: white_pawn.id, use_route: game_piece_path(game, white_pawn) }

      expect(response).to have_http_status(:success)
      white_pawn.reload
      expect(white_pawn.x_position).to eq nil
      expect(white_pawn.y_position).to eq nil
    end
  end
end