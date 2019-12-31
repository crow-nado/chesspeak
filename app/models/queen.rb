class Queen < Piece
  belongs_to :game

  def image
    return self.image = "&#9812" if self.is_white_piece?
    self.image = "&#9818"
  end

  def valid_moves
    @valid_moves = []
    check_squares_on_path(1,0)
    check_squares_on_path(-1,0)
    check_squares_on_path(0,1)
    check_squares_on_path(0,-1)
    check_squares_on_path(1,1)
    check_squares_on_path(-1,1)
    check_squares_on_path(1,-1)
    check_squares_on_path(-1,-1)
    @valid_moves
  end

end
