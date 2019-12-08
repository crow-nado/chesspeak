class King < Piece
  belongs_to :game

  def image
    return self.image = "&#9813" if self.is_white_piece?
    self.image = "&#9819"
  end

end
