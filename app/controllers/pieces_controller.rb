class PiecesController < ApplicationController
  skip_before_action :verify_authenticity_token

  
  def index
    @game = Game.find(params[:game_id])
    render_gamestate_with_pieces
  end

  def show

  end

  def update
    @game = Game.find(params[:game_id])
    new_x = piece_params[:x_position].to_i
    new_y = piece_params[:y_position].to_i
    captured_piece = @game.pieces.find_by(x_position: new_x, y_position: new_y)
    piece = Piece.find(params[:id])
    if piece.valid_move?(new_x, new_y)
      captured_piece.update_attributes(x_position: nil, y_position: nil) unless captured_piece.nil?
      piece.update_attributes(piece_params)
      piece.update_attribute(:updated_at, Time.now)
      @game.change_player_turn
      render_gamestate_without_pieces
    else
      head 400
    end
  end

private
  def piece_params
    params.fetch(:piece).permit(:x_position, :y_position)
  end

  def render_gamestate_with_pieces
    render json: @game.to_json(only: :state, methods: [:active_color, :pieces])
  end

  def render_gamestate_without_pieces
    render json: @game.to_json(only: :state, methods: :active_color)
  end


end