class Piece < ApplicationRecord
  # Overrides default in rails to use "type" and instead use "piece_type"
  self.inheritance_column = 'piece_type'
  
end
