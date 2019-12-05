class Queen < Piece
  belongs_to :game

  def image
    return self.image = "&#9812" if self.is_white_piece?
    self.image = "&#9818"
  end

end
