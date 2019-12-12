class AddColorToPiece < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :color, :string
    add_index :pieces, :color
  end
end
