class Bishop < Piece
  belongs_to :game

  def valid_moves
    @valid_moves = []
    check_squares_on_path(1,1)
    check_squares_on_path(-1,1)
    check_squares_on_path(1,-1)
    check_squares_on_path(-1,-1)
    @valid_moves
  end
end
