class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token
  #Fetch request for pieces
  def index
    @game = Game.find(params[:game_id])
    render json: @game.pieces
  end

  def show

  end

  def update
    piece = Piece.find(params[:id])
    new_x = piece_params[:x_position].to_i
    new_y = piece_params[:y_position].to_i
    if piece.valid_move?(new_x, new_y)
      piece.update_attributes(piece_params)
      piece.update_attribute(:updated_at, Time.now)
      head 200
    else
      head 400
    end
  end

  def destroy
    captured_piece = Piece.find(params[:id])
    captured_piece.update_attributes(x_position: nil, y_position: nil)
    head 200
  end

private
  def piece_params
    params.fetch(:piece).permit(:x_position, :y_position)
  end
end