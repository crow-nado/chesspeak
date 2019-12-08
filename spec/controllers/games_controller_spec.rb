require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "POST #create" do
    it "creates a new game with the user as Player 1" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { 
        game: { 
          name: "Test Game!" 
        }
      }
      #Test game created
      game = Game.last
      expect(game.name).to eq("Test Game!")
      expect(response).to redirect_to game_path(game.id)
      #Test player connection
      player1 = User.find_by(id: game.white_player_id).username
      expect(game.white_player_id).to eq(user.id)
      expect(player1).to eq(user.username)
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
    it "doesn't let a user create a game before signing in" do
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "game#update" do
    it "update game with Player 2 as user" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, { white_player_id: user.id})
      user2 = FactoryBot.create(:user)
      sign_in user2

      patch :update, params: { id: game.id, game: { black_player_id: user2.id } }

      game.reload
      #Verifies 2nd Player was added to the Game
      expect(game.black_player_id).to eq(user2.id)
      player2 = User.find_by(id: game.black_player_id)
      expect(player2.username).to eq(user2.username)
    end

    it "will not allow two players with the same ID" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, { white_player_id: user.id})
      sign_in user

      patch :update, params: { id: game.id, game: { black_player_id: user.id } }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end