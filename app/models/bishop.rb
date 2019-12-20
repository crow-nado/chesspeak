class Bishop < Piece
  belongs_to :game

  def image
    return self.image = "&#9815" if self.is_white_piece?
    self.image = "&#9821"
  end

  def valid_moves
    @valid_moves = []
    add_valid_forward_right_path
    add_valid_forward_left_path
    add_valid_backward_left_path
    add_valid_backward_right_path
    @valid_moves
  end

end
