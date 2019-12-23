class Knight < Piece
  belongs_to :game

  def valid_moves
    @valid_moves = [{x: 4, y:7}, {x:6, y:7}, {x:4,y:3}, {x:6,y:3},{x:7,y:4},{x:7,y:6},{x:3,y:4},{x:3,y:6}]
  end

end
