class Piece < ApplicationRecord
  # Overrides default in rails to use "type" and instead use "piece_type"
  # self.inheritance_column = 'piece_type'
  belongs_to :game
  attr_accessor :image

  def as_json(options={})
    super(only: [:x_position, :y_position, :player_id, :type, :image],
          methods: [:image])
  end
end
