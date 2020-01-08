require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "#populate_white_pawns" do
    it "places the white pawns in the Game" do
      game = Game.create()
      game.populate_white_pawns
      test_pawn = game.pawns.find_by(y_position: 2)
      expect(test_pawn).to be_instance_of(Pawn)
    end

    it "ties the white_player_id to the white pawns" do
      game = Game.create(white_player_id: 1)
      game.populate_white_pawns
      test_pawn = game.pawns.find_by(y_position: 2)
      expect(test_pawn.player_id).to eq 1
      expect(test_pawn.is_white_piece?).to be true
      expect(test_pawn.image).to eq "&#9817"
    end
  end

  describe "#available" do
    it "checks all games and filters out the unavailable ones" do
      game1 = Game.create()
      game2 = Game.create(white_player_id: 1, black_player_id: 2)
      expect(Game.available.count).to eq 1
    end
  end

  describe "#check_square" do
    it "gives the piece at a specific coordinate" do
      game = FactoryBot.create :sample_game
      game.populate_white_pawns
      pawn = game.pieces.first

      expect(game.check_square(pawn.x_position, pawn.y_position)).to be_instance_of(Pawn)
    end
  end

  describe "#change_player_turn" do
    it "checks to see whether or not it's the white player's turn" do
      white_player = FactoryBot.create :user
      black_player = FactoryBot.create :user
      game = FactoryBot.create :sample_game, white_player_id: white_player.id,
             black_player_id: black_player.id
      game.populate_white_side
      game.populate_black_side
      game.start
      expect(game.active_color).to eq "white"
      game.change_player_turn
      expect(game.active_color).to eq "black"
    end
  end

  describe "check scenarios" do
    let!(:user1){FactoryBot.create(:user)}
    let!(:user2){FactoryBot.create(:user)}
    let!(:game) {FactoryBot.create :sample_game,
                white_player_id: user1.id,
                black_player_id: user2.id,
                player_whites_turn: true,
                state: "In Progress"}
    let!(:white_king){FactoryBot.create :sample_white_king,
                x_position: 5, y_position: 1, game_id: game.id}
    let!(:black_king){FactoryBot.create :sample_black_king,
                x_position: 3, y_position: 7, game_id: game.id}
    let!(:white_rook){FactoryBot.create :sample_white_rook,
                  x_position: 2, y_position: 2, game_id: game.id}

    context "active player in check" do
      it "allows a player to move out of check" do
        white_rook.update_attributes(x_position: 3)
        game.change_player_turn; game.check_board_state
        expect(game.state).to eq "Check"

        black_king.update_attributes(x_position: 2)
        game.change_player_turn; game.check_board_state
        expect(game.state).not_to eq "Check"
      end
      fit "requires a player move out of check" do
        white_rook.update_attributes(x_position: 3)
        game.update_attributes(player_whites_turn: false)
        expect(game.state).to eq "Check"
        expect(black_king.valid_move?(3,6)).to be false
      end
    end

    context "check in one move" do
      it "allows a player put an opponent in check" do
        expect(game.state).to eq "In Progress"
        white_rook.update_attributes(y_position: 7)
        game.change_player_turn; game.check_board_state
        expect(game.state).to eq "Check"
      end
    end

    context "checkmate" do
      it "ends the game when the king is in checkmate" do
        game.populate_white_side
        game.populate_black_side

        #Fool's checkmate
        white_pawn_1 = game.pawns.find_by(x_position: 6, y_position: 2)
        white_pawn_2 = game.pawns.find_by(x_position: 7, y_position: 2)
        white_king   = game.kings.find_by(color: "white")

        black_pawn   = game.pawns.find_by(x_position: 5, y_position: 7)
        black_queen  = game.queens.find_by(color: "black")

        white_pawn_1.update_attributes(y_position: 3)
        black_pawn.update_attributes(y_position: 5)
        white_pawn_2.update_attributes(y_position: 4)
        black_queen.update_attributes(x_position: 8, y_position: 4)

        game.check_board_state

        expect(game.state).to eq "Checkmate"
      end
    end

  end
end