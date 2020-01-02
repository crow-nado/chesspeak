class BoardState
  def self.in_check?(game, king)
    pieces = game.pieces.where.not(color: king.color)
    pieces.each do |piece|
      if piece.valid_move?(king.x_position, king.y_position)
        game.state = "Check" 
        break
      end
    end
    game.state == "Check"? true : false
  end
end