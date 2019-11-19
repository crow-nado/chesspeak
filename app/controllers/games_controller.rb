class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    # Show public/available games?
  end

  def create
    game = Game.create(name: "Test Game!", white_player_id: current_user.id)
    game.populate!
    redirect_to game_path(game)
  end

  def show
    @game = Game.find(params[:id])
    @player_white = User.find_by(id: @game.white_player_id)
    # @white_username = player_white.username
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
