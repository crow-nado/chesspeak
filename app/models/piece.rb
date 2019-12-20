class Piece < ApplicationRecord
  # Overrides default in rails to use "type" and instead use "piece_type"
  self.inheritance_column = 'piece_type'
  belongs_to :game
  attr_accessor :image
  alias_attribute :x, :x_position
  alias_attribute :y, :y_position

  def as_json(options={})
    super(only: [:id, :x_position, :y_position, :player_id, :piece_type, :image, :color],
          methods: [:image])
  end

  def valid_move?(x, y)
    valid_moves.include?({x: x, y: y}) && in_boundary?(x, y)
  end

  def is_white_piece?
    color == "white"
  end

  def first_move?
    created_at == updated_at
  end

  def is_obstructed_vertical?(x, y)
    range = y_range(y)
    range.each do |n|
      return true if square_occupied?(x, n)
    end
    return false
  end

  def is_obstructed_horizontal?(x, y)
    range = x_range(x)
    range.each do |n|
      return true if square_occupied?(n, y)
    end
    return false
  end

  def is_obstructed_diagonal?(x, y)
    x_axis = x_range(x)
    y_axis = y_range(y)
    combined_range = x_axis.zip(y_axis)

    combined_range.each do |pair|
      return true if square_occupied?(pair[0], pair[1])
    end
  end

  private
  def in_boundary?(x, y)
    x <= 7 && x>=0 && y <= 7 && y>=0
  end

  def x_range(x)
    self.x_position > x ? (x+1..self.x_position-1) : (self.x_position+1..x-1)
  end

  def y_range(y)
    self.y_position > y ? (y+1..self.y_position-1) : (self.y_position+1..y-1)
  end

  def square_occupied?(x, y)
    !self.game.check_square(x, y).nil?
  end

  def is_enemy(piece)
    !piece.nil? && piece.color != self.color
  end

  def is_friendly(piece)
    !piece.nil? && piece.color == self.color
  end

  def check_squares_on_path(x_direction, y_direction)
    x_path = self.x + x_direction
    y_path = self.y + y_direction
    until !in_boundary?(x_path, y_path)
      piece = self.game.check_square(x_path, y_path)
      break if is_friendly(piece)
      @valid_moves.push(x: x_path, y: y_path)
      break if is_enemy(piece)
      x_path += x_direction
      y_path += y_direction
    end
  end
  
end
