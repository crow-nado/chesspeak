class Pawn < Piece
  belongs_to :game

  def image
    return self.image = "&#9817" if self.is_white_piece?
    self.image = "&#9823"
  end

  private

  def valid_moves
    if self.is_white_piece?
      [
        {x: self.x_position, y: self.y_position+1}
      ]
    else
      [
        {x: self.x_position, y: self.y_position-1}
      ]
    end
  end

end
