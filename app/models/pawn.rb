class Pawn < Piece
  belongs_to :game
  attr_accessor :image

  def image
    return self.image = "&#9817" if self.y_position == 2
    return self.image = "&#9823" if self.y_position == 7
  end

  def as_json(options={})
    super(only: [:x_position, :y_position, :player_id, :type, :image],
         methods: [:image])
  end


end
