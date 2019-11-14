class Pawn < Piece
  belongs_to :game
  after_initialize :set_image
  attr_accessor :image

  private

  def set_image
    return self.image = "&#9817" if self.y_position== 2
    return self.image = "&#9823" if self.y_position == 7
  end
end
