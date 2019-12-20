class Bishop < Piece
  belongs_to :game

  def image
    return self.image = "&#9815" if self.is_white_piece?
    self.image = "&#9821"
  end

  def valid_moves
    @valid_moves = []
    check_squares_on_path(1,1)
    check_squares_on_path(-1,1)
    check_squares_on_path(1,-1)
    check_squares_on_path(-1,-1)
    @valid_moves
  end

end
