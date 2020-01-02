class King < Piece
  belongs_to :game

  def valid_moves
    @valid_moves = []
    adjacentSquares.each do |square|
      piece = self.game.check_square(square[:x], square[:y])
      @valid_moves.push(square) unless is_friendly(piece)
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
