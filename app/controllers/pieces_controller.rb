class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @game = Game.find(params[:game_id])
    render json: @game.pieces
  end

  def show

  end

  def update

  end
end
