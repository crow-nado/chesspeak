class Knight < Piece
  belongs_to :game

  def valid_moves
    @valid_moves = []
    add_L_pattern(-1,2)
    add_L_pattern(1,2)
    @valid_moves
  end

  def rotate_90(delta_x,delta_y)
    new_delta_x, new_delta_y = delta_y, (-delta_x)
  end

  def add_L_pattern(delta_x, delta_y)
    4.times do
      square = self.game.check_square(x + delta_x, y + delta_y)
      @valid_moves.push({x: x + delta_x, y: y + delta_y}) unless is_friendly(square)
      delta_x, delta_y = rotate_90(delta_x, delta_y)
    end
  end

end
