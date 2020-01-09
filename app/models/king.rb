class King < Piece
  belongs_to :game

  def valid_move?(x, y)
    if !in_boundary?(x,y) || self.game.move_into_check(x,y)
      return false
    elsif valid_moves.include?({x: x, y: y})
      return true
    else
      return false
    end
  end

  def valid_moves
    @valid_moves = []
    adjacent_squares.each do |square|
      x, y = square[:x], square[:y]
      piece = self.game.check_square(x, y)
      if !is_friendly(piece)
        unless self.game.has_enemy_pawns_diagonal(x, y, self.color)
          @valid_moves.push({x: x, y: y})
        end
      end
    end
    @valid_moves
  end

  private

  def adjacent_squares
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