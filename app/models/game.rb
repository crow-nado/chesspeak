class Game < ApplicationRecord
  has_many :pieces

  def populate!
    populate_white_side
    populate_black_side
  end

  def populate_white_side
    populate_row(1)
    populate_row(2)
  end

  def populate_black_side
    populate_row(8)
    populate_row(7)
  end


  def populate_row(row)
    8.times do |column|
      self.pieces.create(x_position: column+1, y_position: row)
    end
  end
end
