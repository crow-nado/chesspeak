class Game < ApplicationRecord
  has_many :pawns
  has_many :rooks
  has_many :knights
  has_many :bishops
  has_many :kings
  has_many :queens
  has_many :pieces
  scope :available, -> { where(black_player_id: nil) }

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
    self.kings.create(x_position: 4, y_position: 1, player_id: white_player_id, color: "white")
    self.queens.create(x_position: 5, y_position: 1, player_id: white_player_id, color: "white")
  end

  def populate_black_king_and_queen
    self.kings.create(x_position: 4, y_position: 8, player_id: black_player_id, color: "black")
    self.queens.create(x_position: 5, y_position: 8, player_id: black_player_id, color: "black")
  end

  def populate_row(row)
    8.times do |column|
      self.pieces.create(x_position: column+1, y_position: row)
    end
  end

  def check_square(x, y)
    self.pieces.find_by(x_position: x, y_position: y)
  end

  def in_check?(king)
    pieces = self.pieces.where.not(color: king.color)
    pieces.each do |piece|
      if piece.valid_move?(king.x_position, king.y_position)
        self.update_attribute(:state, "Check") 
        break
      end
      self.update_attribute(:state, "In Progress") 
    end
    self.state == "Check" ? true : false
  end

  def still_in_check?(x, y, color)
    # prior_state = self.state
    king = self.kings.find_by(color: color)
    king.assign_attributes(x: x, y: y)
    puts king.x, king.y
    puts check_square(3,4)
    in_check?(king)
  end

  def board_state
    kings = []
    kings.push(self.pieces.find_by(piece_type: "King"))
    kings.each {|king| in_check?(king) unless king.nil? }
  end

  def has_enemy_pawns_diagonal(x,y,color)
    king = self.kings.find_by(color: color)
    diagonal_ne_piece = check_square(x+1,y+1)
    diagonal_ne_piece.is_a Pawn && king.is_enemy(diagonal_ne_piece)
  end
end
