class BoardState
  def initialize(game)
    @game = game
    @state = "in progress"
  end

  def in_check?(king)
    pieces = @game.pieces.where.not(color: king.color)
    pieces.each do |piece|
      if piece.valid_move?(king.x_position, king.y_position)
        @state = "check" 
        break
      end
    end
    @state == "check"? true : false
  end
end