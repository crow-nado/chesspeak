require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "Game#create" do
    it "creates a new game with the user as Player 1" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { 
        game: { 
          name: "Test Game!" 
        }
      }

      game = Game.last
      expect(response).to redirect_to game_path(game.id)
      expect(game.white_player_id).to eq(user.id)
      expect(game.name).to eq("Test Game!")
    end
    it "populates all the game pieces" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { 
        game: { 
          name: "Test Game!" 
        }
      }

      game = Game.last
      expect(game.pieces.count).to eq 32
    end
  end

  it "doesn't let a user creat a game before signing in" do
    post :create
    expect(response).to redirect_to(new_user_session_path)
  end
end