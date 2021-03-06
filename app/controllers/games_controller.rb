class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @games = Game.not_sample.available.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params.merge(white_player_id: current_user.id))
    @game.populate_white_side
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @player_white = User.find_by(id: @game.white_player_id)
    @player_black = User.find_by(id: @game.black_player_id)
  end

  def update
    game = Game.find(params[:id])
    if game.white_player_id != current_user.id
      game.update(black_player_id: current_user.id)
      game.populate_black_side
      game.start
    end
    redirect_to game_path(game)
  end

private
  def game_params
    params.require(:game).permit(:name, :white_player_id, :black_player_id)
  end
end
