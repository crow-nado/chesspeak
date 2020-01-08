require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#index" do
    it "loads a page of available games to join" do
      user = FactoryBot.create(:user)
      sign_in user

      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe "games#new" do
    it "loads a form for a user to create a new game" do
      user = FactoryBot.create(:user)
      sign_in user

      get :new

      expect(response).to have_http_status(:success)
    end
  end

  describe "games#create" do
    it "creates a new game with the user as Player 1" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { 
        game: { 
          name: "Test Game!" 
        }
      }

      game = Game.last
      expect(game.name).to eq("Test Game!")
      expect(game.state).to eq("Not started")
      expect(response).to redirect_to game_path(game.id)

      player1 = User.find_by(id: game.white_player_id).username
      expect(game.white_player_id).to eq(user.id)
      expect(player1).to eq(user.username)
    end

    it "populates white game pieces" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { 
        game: { 
          name: "Test Game!" 
        }
      }

      game = Game.last
      expect(game.pieces.count).to eq 16
    end

    it "doesn't let a user create a game before signing in" do
      post :create
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "games#show" do
    it "should successfully show the game board if the game is found" do
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game, { white_player_id: user.id})

      get :show, params: { id: game.id }

      expect(response).to have_http_status(:success)
    end
  end

  describe "games#update" do
    it "update game with Player 2 as user" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, { white_player_id: user.id})
      user2 = FactoryBot.create(:user)
      sign_in user2

      expect(game.state).to eq("Not started")

      patch :update, params: { id: game.id, game: { black_player_id: user2.id } }

      expect(response).to redirect_to game_path(game.id)
      game = game.reload
      #Verifies 2nd Player was added to the Game
      player2 = User.find_by(id: game.black_player_id)
      expect(game.black_player_id).to eq(user2.id)
      expect(game.state).to eq("In Progress")
      expect(player2.username).to eq(user2.username)
    end
  end
end