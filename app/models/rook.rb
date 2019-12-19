class Rook < Piece
  belongs_to :game

  def image
    return self.image = "&#9814" if self.is_white_piece?
    self.image = "&#9820"
  end

  def valid_moves
    @valid_moves = []
    add_forward_movement
    add_backward_movement
    add_right_movement
    add_left_movement
    @valid_moves
  end

  def add_forward_movement
    row = self.y + 1
    until row > 7
      piece = self.game.check_square(self.x, row)
      break if is_friendly(piece)
      @valid_moves.push({x: self.x, y: row})
      break if is_enemy(piece)
      row += 1
    end
  end

  def add_backward_movement
    row = self.y - 1
    until row < 0
      piece = self.game.check_square(self.x, row)
      break if is_friendly(piece)
      @valid_moves.push({x: self.x, y: row})
      break if is_enemy(piece)
      row -= 1
    end
  end

  def add_right_movement
    column = self.y + 1
    until column > 7
      piece = self.game.check_square(column, self.y)
      break if is_friendly(piece)
      @valid_moves.push({x: column, y: self.y})
      break if is_enemy(piece)
      column += 1
    end
  end

  def add_left_movement
    column = self.y - 1
    until column < 0
      piece = self.game.check_square(column, self.y)
      break if is_friendly(piece)
      @valid_moves.push({x: column, y: self.y})
      break if is_enemy(piece)
      column -= 1
    end
  end

end
