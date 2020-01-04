class Game < ApplicationRecord
  has_many :pawns
  has_many :rooks
  has_many :knights
  has_many :bishops
  has_many :kings
  has_many :queens
  has_many :pieces
  scope :available, -> { where(black_player_id: nil) }
  attr_accessor :turn_counter, :inactive_player_valid_moves
  after_initialize :set_turn_counter_to_1, :set_inactive_player_valid_moves

  def set_turn_counter_to_1
    @turn_counter = 1
  end

  def set_inactive_player_valid_moves
    @inactive_player_valid_moves = Array.new
  end

  def start
    self.update_attribute(:state, "In Progress")
  end

  def change_player_turn
    @turn_counter += 1
    fill_inactive_player_valid_moves
    check_board_state
  end

  def active_color
    @turn_counter % 2 == 1 ? "white" : "black"
  end

  def check_square(x, y)
    self.pieces.find_by(x_position: x, y_position: y)
  end

  def check_board_state
    king = self.kings.find_by(color: active_color)
    if @inactive_player_valid_moves.include?({x: king.x_position, y: king.y_position})
      puts "Should be updating!"
      self.update_attribute(:state, "Check")
    else
      puts "Sall good"
      self.update_attribute(:state, "In Progress")
    end
    self.state == "Check" ? true : false
  end

  # def still_in_check?(x, y, color)
  #   king = self.kings.find_by(color: color)
  #   king.assign_attributes(x: x, y: y)
  #   in_check?(king)
  # end

  # def board_state
  #   kings = []
  #   kings.push(self.pieces.find_by(piece_type: "King"))
  #   kings.each do |king| 
  #     unless king.nil?
  #       self.update_attribute(:state, "Check") if in_check?(king)
  #       break
  #     end
  #   end
  # end

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

  def fill_inactive_player_valid_moves
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