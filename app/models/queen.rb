class Queen < Piece
  belongs_to :game

  def image
    return self.image = "&#9812" if self.y_position == 1
    return self.image = "&#9818"
  end

end
