class Game < ApplicationRecord
  has_many :pieces
  has_many :users

  def populate!
    
  end
end
