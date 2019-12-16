class Pawn < Piece
  belongs_to :game
  #alias x x_position
  #alias y y_position

  def image
    return self.image = "&#9817" if self.is_white_piece?
    self.image = "&#9823"
  end

  def valid_moves
    @valid_moves = []
    add_enemy_diagonal
    if self.is_white_piece?
      @valid_moves.push({x: self.x_position, y: self.y_position+1})
      @valid_moves.push({x: self.x_position, y: self.y_position+2}) if self.first_move?
    else
      @valid_moves.push({x: self.x_position, y: self.y_position-1})
      @valid_moves.push({x: self.x_position, y: self.y_position-2}) if self.first_move?
    end
    return @valid_moves
  end

  def has_enemy_diagonal
    if self.is_white_piece?
      if self.game.check_square(self.x_position+1, self.y_position+1).nil?
        return false
      end
      square = !self.game.check_square(self.x_position+1, self.y_position+1).is_white_piece?
    else
      return self.game.check_square(self.x_position-1, self.y_position-1).is_white_piece?
    end
  end

  def add_enemy_diagonal
    x,y = self.x_position, self.y_position
    if self.is_white_piece?
      check_and_add_square(x-1, y+1)
      check_and_add_square(x+1, y+1)
    else
      check_and_add_square(x-1, y-1)
      check_and_add_square(x+1, y-1)
    end
  end

  def check_and_add_square(x,y)
    square = self.game.check_square(x, y)
    if is_enemy(square)
      @valid_moves.push({x: x, y: y})
    end
  end

  def is_enemy(piece)
    !piece.nil? && piece.color != self.color
  end
end
