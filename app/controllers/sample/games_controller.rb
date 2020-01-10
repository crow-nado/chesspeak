class Sample::GamesController < ApplicationController

  require 'faker'

  def create
    @game = Game.create()
    @game.populate_white_side
    @game.populate_black_side
    @game.start
    redirect_to sample_game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @player_white = {username: generate_random_name}
    @player_black = {username: generate_random_name}
    @game.update(name: "#{@player_white[:username]} VS #{@player_black[:username]}")
    render template: "games/show"
  end

private

  def generate_random_name
    selections = [
      Faker::Artist.name,
      Faker::FunnyName.name,
      Faker::GreekPhilosophers.name,
      Faker::Superhero.name,
      Faker::Beer.name
    ]
    selections.sample
  end

end
