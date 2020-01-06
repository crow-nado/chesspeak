module GameBoard
  def start(game=self)
    game.turn_counter = 1
    game.update_attribute(:state, "In Progress")
    game.fill_inactive_player_valid_moves("black", game)
  end

  def change_player_turn(game=self)
    game.fill_inactive_player_valid_moves(active_color, game)
    game.turn_counter += 1
    game.board_state
  end

  def active_color(game=self)
    game.turn_counter % 2 == 1 ? "white" : "black"
  end

  def check_square(x, y, game=self)
    game.pieces.find_by(x_position: x, y_position: y)
  end

  def in_check?(king, game=self)
    state = nil
    if game.inactive_player_valid_moves.include?({x: king.x_position, y: king.y_position})
      state = "Check"
    else
      state = "In Progress"
    end
    state == "Check" ? true : false
  end

  def board_state(game=self)
    kings = []
    kings.push(game.pieces.find_by(piece_type: "King"))
    kings.each do |king| 
      unless king.nil?
        game.update_attribute(:state, "Check") if in_check?(king, game)
        break
      end
    end
  end

  def has_enemy_pawns_diagonal(x,y,color,game=self)
    king = game.kings.find_by(color: color)
    if king.is_white_piece?
      diagonal_east_piece = check_square(x+1,y+1,game)
      diagonal_west_piece = check_square(x-1,y+1,game)
    else
      diagonal_east_piece = check_square(x+1,y-1,game)
      diagonal_west_piece = check_square(x-1,y-1,game)
    end
    if king.is_enemy(diagonal_east_piece)
      return true if diagonal_east_piece.is_a? Pawn
    elsif king.is_enemy(diagonal_west_piece)
      return true if diagonal_west_piece.is_a? Pawn
    else
      return false
    end
  end

  def fill_inactive_player_valid_moves(color, game=self)
    pieces = game.pieces.where.not(color: color)
    game.inactive_player_valid_moves = []
    pieces.each do |piece|
      game.inactive_player_valid_moves.push(piece.valid_moves)
    end
     game.inactive_player_valid_moves = game.inactive_player_valid_moves.flatten
  end
end