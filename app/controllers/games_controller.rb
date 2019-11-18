class GamesController < ApplicationController
  # Just for testing
  skip_before_action :verify_authenticity_token

  def index
    # Show public/available games?
  end

  def create
    if current_user
      game = Game.create(name: "Test Game!", white_player_id: current_user.id)
    else
      #Only for testing purposes - update when validation is implemented
      game = Game.create(name: "Test Game!")
    end
    game.populate!
    redirect_to game_path(game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    # Add second player?
  end

private
  #Review whether name will be automated or entered by user - consider user stories for how game name is used
  def game_params
    params.require(:game).permit(:name, :white_player_id)
  end
end
