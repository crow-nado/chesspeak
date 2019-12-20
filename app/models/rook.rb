class Rook < Piece
  belongs_to :game

  def image
    return self.image = "&#9814" if self.is_white_piece?
    self.image = "&#9820"
  end

  def valid_moves
    @valid_moves = []
    add_valid_forward_path
    add_valid_backward_path
    add_valid_right_path
    add_valid_left_path
    @valid_moves
  end

end


