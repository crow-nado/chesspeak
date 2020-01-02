class King < Piece
  belongs_to :game

  def valid_moves
    @valid_moves = []
    adjacentSquares.each do |square|
      piece = self.game.check_square(square[:x], square[:y])
      if !is_friendly(piece) && !self.game.move_into_check?(square[:x], square[:y], self.color)
        @valid_moves.push(square)
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
