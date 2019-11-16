class Queen < Piece
  belongs_to :game
  attr_accessor :image

  def image
    return self.image = "&#9812" if self.y_position == 1
    return self.image = "&#9818" if self.y_position == 8
  end

  def as_json(options={})
    super(only: [:x_position, :y_position, :player_id, :type, :image],
         methods: [:image])
  end
end
