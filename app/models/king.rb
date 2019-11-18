class King < Piece
  belongs_to :game

  def image
    return self.image = "&#9813" if self.y_position == 1
    return self.image = "&#9819"
  end

end
