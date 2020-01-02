class BoardState
  def initialize(game)
    @game = game
    @white_king = @game.kings.find_by(color: "white")
    @black_king = @game.kings.find_by(color: "black")
    @state = "in progress"
  end

  def in_check?
    @pieces = @game.pieces.all
    @pieces.each do |piece|
      if piece.is_enemy(@black_king)
        if piece.valid_move?(@black_king.x_position, @black_king.y_position)
          @state = "check" 
          break
        end
      end
    end
    @state = "check"? true : false
  end
end