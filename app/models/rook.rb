class Rook < Piece
  belongs_to :game

  def image
    return self.image = "&#9814" if self.y_position == 1
    return self.image = "&#9820"
  end

end
