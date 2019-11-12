class GamesController < ApplicationController
  # Just for testing
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    game = Game.create(name: "Test Game!")
    redirect_to game_path(game)
  end

  def show
    @game = Game.find(params[:id])
  end
end
