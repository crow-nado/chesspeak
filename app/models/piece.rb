class Piece < ApplicationRecord
  # Overrides default in rails to use "type" and instead use "piece_type"
  # self.inheritance_column = 'piece_type'
  belongs_to :game
  
  
  
  
  # There should be a way to store the repeated piece logic in here. Not very DRY right now (below code does not work)
  
  # attr_accessor :image

  # def image(white_image, black_image, white_position_row)
  #   return self.image = white_image if self.y_position == white_position_row
  #   return self.image = black_image
  # end

  # def as_json(options={})
  #   super(only: [:x_position, :y_position, :player_id, :type, :image],
  #         methods: [:image])
  # end
end
