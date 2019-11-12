require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "#populate!" do
    it "populates the game with pieces" do
      game = Game.create()
      game.populate!
      expect(game.pieces.count).to eq 32
    end
  end
end
