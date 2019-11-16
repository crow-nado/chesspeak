class Pawn < Piece
  belongs_to :game

  def image
    return self.image = "&#9817" if self.y_position == 2
    return self.image = "&#9823"
  end

end
