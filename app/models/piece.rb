class Piece < ApplicationRecord
  # Overrides default in rails to use "type" and instead use "piece_type"
  self.inheritance_column = 'piece_type'
  belongs_to :game
  attr_accessor :image

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
    if created_at == updated_at
      return true
    else
      return false
    end
  end

  def is_obstructed_vertical?(x, y)
    range = self.y_position > y ? (y+1..self.y_position-1) : (self.y_position+1..y-1)
    range.each do |n|
      return true if !self.game.check_square(x, n).nil?
    end
  end

  def is_obstructed_horizontal?(x, y)
    range = self.x_position > x ? (x+1..self.x_position-1) : (self.x_position+1..x-1)
    range.each do |n|
      return true if !self.game.check_square(n, y).nil?
    end
  end

  private
  def in_boundary?(x, y)
    x <= 7 && x>=0 && y <= 7 && y>=0
  end
end
