class Bishop < Piece
  belongs_to :game

  def image
    return self.image = "&#9815" if self.is_white_piece?
    self.image = "&#9821"
  end

  def valid_moves
    @valid_moves = []
    forward_right_diagonal_path
    backward_right_diagonal_path
    backward_left_diagonal_path
    forward_left_diagonal_path
    @valid_moves
  end

  def forward_right_diagonal_path
    row, column = self.y+1, self.x+1
    until row > 7 || column > 7
      piece = self.game.check_square(column, row)
      break if is_friendly(piece)
      @valid_moves.push({x: column, y: row})
      break if is_enemy(piece)
      row += 1
      column += 1
    end
  end

  def backward_right_diagonal_path
    row, column = self.y-1, self.x+1
    until row < 0 || column > 7
      piece = self.game.check_square(column, row)
      break if is_friendly(piece)
      @valid_moves.push({x: column, y: row})
      break if is_enemy(piece)
      row -= 1
      column += 1
    end
  end

  def backward_left_diagonal_path
    row, column = self.y-1, self.x-1
    until row < 0 || column < 0
      piece = self.game.check_square(column, row)
      break if is_friendly(piece)
      @valid_moves.push({x: column, y: row})
      break if is_enemy(piece)
      row -= 1
      column -= 1
    end
  end

  def forward_left_diagonal_path
    row, column = self.y+1, self.x-1
    until row > 7 || column < 0
      piece = self.game.check_square(column, row)
      break if is_friendly(piece)
      @valid_moves.push({x: column, y: row})
      break if is_enemy(piece)
      row += 1
      column -= 1
    end
  end

end
