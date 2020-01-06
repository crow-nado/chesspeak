require 'rails_helper'

xdescribe "Check Scenarios", type: :feature do
  let!(:user1){FactoryBot.create(:user)}
  let!(:user2){FactoryBot.create(:user)}
  before :each do
    login(user1)
  end

  it "check in one move", js: true do
    game = FactoryBot.create :black_check_in_one_move,
            white_player_id: user1.id, black_player_id: user2.id
    black_king = game.kings.create(x_position: 3, y_position: 7, game_id: game.id, color: "black")
    white_rook = game.rooks.create(x_position: 2, y_position: 2, game_id: game.id, color: "white")

    visit game_path(game.id)

    #Select piece to move into check
    find("[data-x='2'][data-y='2']").click

    #Select square to move piece to
    find("[data-x='2'][data-y='7']").click

    expect(page).to have_content("Submit")
    click_button 'Submit'

    expect(page).to have_content("Check")
  end
end
