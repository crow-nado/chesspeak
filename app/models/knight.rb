class Knight < Piece
  belongs_to :game

  def image
    return self.image = "&#9816" if self.is_white_piece?
    self.image = "&#9822"
  end

end
