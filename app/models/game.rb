class Game < ApplicationRecord
  has_many :pawns
  has_many :rooks
  has_many :knights
  has_many :bishops
  has_many :kings
  has_many :queens
  has_many :pieces
  scope :available, -> { where(black_player_id: nil) }

  def populate!
    populate_white_side
    populate_black_side
  end

  def assign_black_side
    black_pieces = Piece.where(game_id: id, player_id: nil)
    black_pieces.update_all(player_id: black_player_id)
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
      self.pawns.create(x_position: column+1, y_position: 2, player_id: white_player_id)
    end
  end

  def populate_black_pawns
    8.times do |column|
      self.pawns.create(x_position: column+1, y_position: 7, player_id: black_player_id)
    end
  end

  def populate_white_rooks
    [1,8].each do |column|
      self.rooks.create(x_position: column, y_position: 1, player_id: white_player_id)
    end
  end

  def populate_black_rooks
    [1,8].each do |column|
      self.rooks.create(x_position: column, y_position: 8, player_id: black_player_id)
    end
  end

  def populate_white_knights
    [2,7].each do |column|
      self.knights.create(x_position: column, y_position: 1, player_id: white_player_id)
    end
  end

  def populate_black_knights
    [2,7].each do |column|
      self.knights.create(x_position: column, y_position: 8, player_id: black_player_id)
    end
  end

  def populate_white_bishops
    [3,6].each do |column|
      self.bishops.create(x_position: column, y_position: 1, player_id: white_player_id)
    end
  end

  def populate_black_bishops
    [3,6].each do |column|
      self.bishops.create(x_position: column, y_position: 8, player_id: black_player_id)
    end
  end

  def populate_white_king_and_queen
    self.kings.create(x_position: 4, y_position: 1, player_id: white_player_id)
    self.queens.create(x_position: 5, y_position: 1, player_id: white_player_id)
  end

  def populate_black_king_and_queen
    self.kings.create(x_position: 4, y_position: 8, player_id: black_player_id)
    self.queens.create(x_position: 5, y_position: 8, player_id: black_player_id)
  end

  def populate_row(row)
    8.times do |column|
      self.pieces.create(x_position: column+1, y_position: row)
    end
  end
end
