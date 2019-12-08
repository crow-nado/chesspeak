class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @game = Game.find(params[:game_id])
    render json: @game.pieces
  end

  def show

  end

  def update
    piece = Piece.find(params[:id])
    if piece.valid_move?
      piece.update_attributes(piece_params)
      render json: piece
    #Else condition to handle response for invalid_moves
    end
  end

private
  def piece_params
    params.fetch(:piece).permit(:x_position, :y_position)
  end
end
