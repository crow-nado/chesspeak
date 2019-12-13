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
    valid_moves.include?({x: x, y: y})
  end

  def is_white_piece?
    color == "white"
  end
end
