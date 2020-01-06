class AddDefaultStateValueToGame < ActiveRecord::Migration[5.2]
  def change
    change_column :games, :state, :string, default: "Not started"
  end
end
