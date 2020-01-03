class King < Piece
  belongs_to :game

  def valid_moves
    @valid_moves = []
    adjacentSquares.each do |square|
      x, y = square[:x], square[:y]
      piece = self.game.check_square(x, y)
      if is_enemy(piece) && !self.game.still_in_check?(x, y, self.color)
        unless self.game.has_enemy_pawns_diagonal(x, y)
          @valid_moves.push({x: x, y: y})
        end
      end
    end
    @valid_moves
  end

  def adjacentSquares
    squares = []
    [-1, 1].each do |n|
      squares.push({x: self.x + n, y: self.y})
      squares.push({x: self.x,     y: self.y + n})
      squares.push({x: self.x + n, y: self.y + n})
      squares.push({x: self.x + n, y: self.y - n})
    end
    squares
  end

end
