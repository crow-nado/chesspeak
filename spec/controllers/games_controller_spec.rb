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
      player1 = User.find_by(id: game.white_player_id).email
      expect(game.white_player_id).to eq(user.id)
      expect(player1).to eq(user.email)
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

  it "doesn't let a user create a game before signing in" do
    post :create
    expect(response).to redirect_to(new_user_session_path)
  end
end