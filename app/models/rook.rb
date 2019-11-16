class Rook < Piece
  belongs_to :game
  attr_accessor :image

  def image
    return self.image = "&#9814" if self.y_position == 1
    return self.image = "&#9820" if self.y_position == 8
  end

  def as_json(options={})
    super(only: [:x_position, :y_position, :player_id, :type, :image],
         methods: [:image])
  end
end
