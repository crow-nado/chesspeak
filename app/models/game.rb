class Game < ApplicationRecord
  has_many :pawns
  has_many :rooks
  has_many :knights
  has_many :bishops
  has_many :kings
  has_many :queens
  has_many :pieces
  scope :available, -> { where(black_player_id: nil) }

  def start
    self.update_attribute(:state, "In Progress")
    self.update_attribute(:player_whites_turn, true)
  end

  def active_color
    player_whites_turn == true ? "white" : "black"
  end


  def change_player_turn
    self.toggle!(:player_whites_turn)
  end

  def check_square(x, y)
    self.pieces.find_by(x_position: x, y_position: y)
  end

  def board_in_check?
    king = self.kings.find_by(color: active_color)
    if inactive_player_valid_moves.include?({x: king.x_position, y: king.y_position})
      self.update_attribute(:state, "Check")
      check_for_checkmate(king)
    else
      self.update_attribute(:state, "In Progress")
    end
    self.state == "Check" || self.state == "Checkmate" ? true : false
  end

  def check_for_checkmate(king)
    possible_moves = king.valid_moves.keep_if { |move| king.in_boundary?(move[:x], move[:y]) }
    if possible_moves & inactive_player_valid_moves == possible_moves
      self.update_attribute(:state, "Checkmate")
      self.lock!
      self.pieces.each { |piece| piece.lock! }
    end
  end

  def has_enemy_pawns_diagonal(x,y,color)
    king = self.kings.find_by(color: color)
    if king.is_white_piece?
      diagonal_east_piece = check_square(x+1,y+1)
      diagonal_west_piece = check_square(x-1,y+1)
    else
      diagonal_east_piece = check_square(x+1,y-1)
      diagonal_west_piece = check_square(x-1,y-1)
    end
    if king.is_enemy(diagonal_east_piece)
      return true if diagonal_east_piece.is_a? Pawn
    elsif king.is_enemy(diagonal_west_piece)
      return true if diagonal_west_piece.is_a? Pawn
    else
      return false
    end
  end

  def move_into_check(x,y)
    inactive_player_valid_moves.include?({x: x, y: y})
  end

  def inactive_player_valid_moves
    @inactive_player_valid_moves = []
    pieces = self.pieces.where.not(color: active_color)
    pieces.each do |piece|
      moves = piece.valid_moves
      moves.each { |move| @inactive_player_valid_moves.push(move) }
    end
    @inactive_player_valid_moves
  end

  def populate_white_side
    populate_white_pawns
    populate_white_rooks
    populate_white_knights
    populate_white_bishops
    populate_white_king_and_queen
  end

  def populate_black_side
    populate_black_pawns
    populate_black_rooks
    populate_black_knights
    populate_black_bishops
    populate_black_king_and_queen
  end


  def populate_white_pawns
    8.times do |column|
      self.pawns.create(x_position: column+1, y_position: 2, player_id: white_player_id, color: "white")
    end
  end

  def populate_black_pawns
    8.times do |column|
      self.pawns.create(x_position: column+1, y_position: 7, player_id: black_player_id, color: "black")
    end
  end

  def populate_white_rooks
    [1,8].each do |column|
      self.rooks.create(x_position: column, y_position: 1, player_id: white_player_id, color: "white")
    end
  end

  def populate_black_rooks
    [1,8].each do |column|
      self.rooks.create(x_position: column, y_position: 8, player_id: black_player_id, color: "black")
    end
  end

  def populate_white_knights
    [2,7].each do |column|
      self.knights.create(x_position: column, y_position: 1, player_id: white_player_id, color: "white")
    end
  end

  def populate_black_knights
    [2,7].each do |column|
      self.knights.create(x_position: column, y_position: 8, player_id: black_player_id, color: "black")
    end
  end

  def populate_white_bishops
    [3,6].each do |column|
      self.bishops.create(x_position: column, y_position: 1, player_id: white_player_id, color: "white")
    end
  end

  def populate_black_bishops
    [3,6].each do |column|
      self.bishops.create(x_position: column, y_position: 8, player_id: black_player_id, color: "black")
    end
  end

  def populate_white_king_and_queen
    self.kings.create(x_position: 5, y_position: 1, player_id: white_player_id, color: "white")
    self.queens.create(x_position: 4, y_position: 1, player_id: white_player_id, color: "white")
  end

  def populate_black_king_and_queen
    self.kings.create(x_position: 5, y_position: 8, player_id: black_player_id, color: "black")
    self.queens.create(x_position: 4, y_position: 8, player_id: black_player_id, color: "black")
  end

  def populate_row(row)
    8.times do |column|
      self.pieces.create(x_position: column+1, y_position: row)
    end
  end


end