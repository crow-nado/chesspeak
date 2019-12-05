class Pawn < Piece
  belongs_to :game

  def image
    return self.image = "&#9817" if self.is_white_piece?
    self.image = "&#9823"
  end

end
