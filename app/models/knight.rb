class Knight < Piece
  belongs_to :game

  def image
    return self.image = "&#9816" if self.y_position == 1
    return self.image = "&#9822"
  end

end
