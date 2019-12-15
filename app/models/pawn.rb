class Pawn < Piece
  belongs_to :game

  def image
    return self.image = "&#9817" if self.is_white_piece?
    self.image = "&#9823"
  end

  private

  def valid_moves
    valid_moves = []
    if self.is_white_piece?
      valid_moves.push({x: self.x_position, y: self.y_position+1})
      valid_moves.push({x: self.x_position, y: self.y_position+2}) if self.first_move?
      valid_moves.push({x: self.x_position+1, y: self.y_position+1}) if can_capture?(self.x_position+1, self.y_position+1, "black")
      valid_moves.push({x: self.x_position-1, y: self.y_position+1}) if can_capture?(self.x_position-1, self.y_position+1, "black")
    else
      valid_moves.push({x: self.x_position, y: self.y_position-1})
      valid_moves.push({x: self.x_position, y: self.y_position-2}) if self.first_move?
    end
    return valid_moves
  end

  # def valid_capture(x, y)
  #   #Determine array of valid captures
  #   if self.is_white_piece?
  #     valid_captures = [
  #       {x: self.x_position+1, y: self.y_position+1},
  #       {x: self.x_position-1, y: self.y_position+1}]
  #     opponant = "black"
  #   else
  #     valid_captures = [
  #       {x: self.x_position+1, y: self.y_position-1},
  #       {x: self.x_position-1, y: self.y_position-1}]
  #     opponant = "white"
  #   end
  #   unoccupied = false if Piece.where(x_position: x, y_position: y, color: opponant, game_id: self.game_id) == nil #Compare array to proposed move, and confirm the color
  #   if !unoccupied && valid_captures.include?({x: x, y: y})
  #     return true
  #   else
  #     return false
  #   end
  # end

  private
  def can_capture?(x, y, color)
    if Piece.where(x_position: x, y_position: y, color: color, game_id: self.game_id) != nil
      return true
    else
      return false
    end
  end
end
