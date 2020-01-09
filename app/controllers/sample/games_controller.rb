class Sample::GamesController < ApplicationController

  def create
    @game = Game.create()
    @game.populate_white_side
    @game.populate_black_side
    @game.start
    redirect_to sample_game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @player_white = {username: "PLAYER WHITE"}
    @player_black = {username: "PLAYER BLACK"}
    render template: "games/show"
  end

private

  def generate_user
    #@player_white.username = @player_white[:username]
  end

end
