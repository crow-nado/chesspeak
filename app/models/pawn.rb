class Pawn < Piece
  belongs_to :game
  alias_attribute :x, :x_position
  alias_attribute :y, :y_position

  def image
    return self.image = "&#9817" if self.is_white_piece?
    self.image = "&#9823"
  end

  def valid_moves
    @valid_moves = []
    add_enemy_diagonal
    if self.is_white_piece?
      @valid_moves.push({x: x, y: y+1}) unless square_occupied?(x, y+1)
      @valid_moves.push({x: x, y: y+2}) if self.first_move? && !is_obstructed_vertical?(x, y+2)
    else
      @valid_moves.push({x: x, y: y-1}) unless square_occupied?(x, y-1)
      @valid_moves.push({x: x, y: y-2}) if self.first_move? && !is_obstructed_vertical?(x, y-2)
    end
    @valid_moves
  end

  def add_enemy_diagonal
    if self.is_white_piece?
      check_and_add_square(x-1, y+1)
      check_and_add_square(x+1, y+1)
    else
      check_and_add_square(x-1, y-1)
      check_and_add_square(x+1, y-1)
    end
  end

  def check_and_add_square(x,y)
    square = self.game.check_square(x, y)
    if is_enemy(square)
      @valid_moves.push({x: x, y: y})
    end
  end


end
