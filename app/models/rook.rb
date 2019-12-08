class Rook < Piece
  belongs_to :game

  def image
    return self.image = "&#9814" if self.is_white_piece?
    self.image = "&#9820"
  end

end
