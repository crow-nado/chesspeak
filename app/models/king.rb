class King < Piece
  belongs_to :game

  def valid_moves
    @valid_moves = []
    adjacentSquares.each do |square|
      x, y = square[:x], square[:y]
      piece = self.game.check_square(x, y)
      puts x, y
      if !is_friendly(piece)
        unless self.game.has_enemy_pawns_diagonal(x, y, self.color) #|| self.game.inactive_player_valid_moves.include?({x: x, y: y})
          puts self.game.active_color
          puts self.game.inactive_player_valid_moves
          puts x, y
          @valid_moves.push({x: x, y: y})
        end
      end
    end
    restrict_movement_into_check
    @valid_moves
  end

  def restrict_movement_into_check
    if self.game.inactive_player_valid_moves.include?({x: x, y: y})
      @valid_moves.delete({x: x, y: y})
    end
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
