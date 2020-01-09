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
    piece = Piece.find(params[:id])
    if piece.valid_move?(new_x, new_y)
      captured_piece = @game.pieces.find_by(x_position: new_x, y_position: new_y)
      piece.assign_attributes(piece_params)
      unless @game.board_in_check?
        #Safe Navigation Operator - http://mitrev.net/ruby/2015/11/13/the-operator-in-ruby/
        captured_piece&.destroy
        piece.save
        @game.change_player_turn
        @game.board_in_check?
        render_gamestate_without_pieces
      else
        head 400
      end
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