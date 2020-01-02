class BoardState
  def self.in_check?(game, king)
    pieces = game.pieces.where.not(color: king.color)
    pieces.each do |piece|
      if piece.valid_move?(king.x_position, king.y_position)
        game.state = "Check" 
        break
      end
      game.state = "In Progress"
    end
    game.state == "Check"? true : false
  end

  def self.move_into_check?(x, y, king)
    game = Game.find_by(id: king.game_id)
    pieces = game.pieces.where.not(color: king.color)
    pieces.each do |piece|
      break false if piece.valid_move?(x, y)
    end
    true
  end
end