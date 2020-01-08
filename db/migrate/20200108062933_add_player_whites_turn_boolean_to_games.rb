class AddPlayerWhitesTurnBooleanToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :player_whites_turn, :boolean
  end
end
