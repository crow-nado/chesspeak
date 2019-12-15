class Pawn < Piece
  belongs_to :game

  def image
    return self.image = "&#9817" if self.is_white_piece?
    self.image = "&#9823"
  end

  private

  def valid_moves
    valid_moves = []
    if self.is_white_piece?
      valid_moves.push({x: self.x_position, y: self.y_position+1})
      valid_moves.push({x: self.x_position, y: self.y_position+2}) if self.first_move?
    else
      valid_moves.push({x: self.x_position, y: self.y_position-1})
      valid_moves.push({x: self.x_position, y: self.y_position-2}) if self.first_move?
    end
    return valid_moves
  end
end
