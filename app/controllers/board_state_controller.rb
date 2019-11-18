class BoardStateController < ApplicationController
  skip_before_action :verify_authenticity_token
  def show
    @game = Game.find(params[:id])
    render json: @game.pieces
  end

  def update

  end
end
