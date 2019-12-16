class Pawn < Piece
  belongs_to :game

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
    if self.is_white_piece?
      left = self.game.check_square(self.x_position+1, self.y_position+1)
      if !left.nil? && left.color != self.color
        @valid_moves.push({x: left.x_position, y: left.y_position})
      end
    else
      right = self.game.check_square(self.x_position-1, self.y_position-1)
      if !right.nil? && right.color != self.color
        @valid_moves.push({x: right.x_position, y: right.y_position})
      end
    end
  end
end
