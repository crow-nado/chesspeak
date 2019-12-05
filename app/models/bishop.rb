class Bishop < Piece
  belongs_to :game

  def image
    return self.image = "&#9815" if self.is_white_piece?
    self.image = "&#9821"
  end

end
