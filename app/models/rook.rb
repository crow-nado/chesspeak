class Rook < Piece
  belongs_to :game

  def image
    return self.image = "&#9814" if self.is_white_piece?
    self.image = "&#9820"
  end

  def valid_moves
    @valid_moves = []
    check_squares_on_path(1,0)
    check_squares_on_path(-1,0)
    check_squares_on_path(0,1)
    check_squares_on_path(0,-1)
    @valid_moves
  end

end


