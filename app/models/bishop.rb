class Bishop < Piece
  belongs_to :game

  def image
    return self.image = "&#9815" if self.y_position == 1
    return self.image = "&#9821"
  end

end
