require 'rails_helper'

#Initial tests to confirm Capybara successfully installed
describe "landing page", type: :feature do
  it "asks a user to sign in or sign up if they are not already signed in" do
    visit '/'
    expect(page).to have_content('SIGN IN')
  end

  it " displays the CREATE NEW GAME! button if a user is signed in" do
    visit '/users/sign_up'

    fill_in 'Username', with: 'test'
    fill_in 'Email', with: 'test@test.test'
    fill_in 'Password', with: 'testtest'
    fill_in 'Password confirmation', with: 'testtest'
    find('input[name="commit"]').click

    expect(page).to have_content('CREATE NEW GAME!')
    expect(page).to have_content('JOIN A GAME!')
    expect(page).to have_content('LOG OUT')
  end
end

describe "game page", type: :feature do
  it "displays the user's username on their side" do
    user = FactoryBot.create(:user)
    visit '/users/sign_in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('CREATE NEW GAME!')
    find('a[id="newGameButton"]').click
    expect(page).to have_content(user.username, maximum: 20)
  end
end

describe "game setup", type: :feature do
  before :each do
    active_user = FactoryBot.create(:user)
    visit '/users/sign_in'
    fill_in 'Email', with: active_user.email
    fill_in 'Password', with: active_user.password
    click_button 'Log in'
  end

  it "creates a new game" do
    visit '/games/new'

    fill_in 'Name', with: 'Test Game'
    click_button 'Create Game'

    game = Game.last
    expect(page).to have_content('Test Game')
    expect(game.pawns.find_by(y_position: 2)).to be_instance_of(Pawn)
    expect(game.pieces.count).to eq 16
    expect(page).to have_content("Player 1 Ready!")
  end

  it "joins an existing game" do
    user = FactoryBot.create(:user)
    game = FactoryBot.create(:game, { white_player_id: user.id})

    visit '/games/'

    click_link 'Join Game'

    expect(page).to have_content("Player 1 Ready!")
    expect(page).to have_content("Player 2 Ready!")
    expect(page).to have_content(game.name)
  end

end


#Initial tests to confirm FactoryBot successfully installed

# These fail with Foundation (Pop ups do not appear. User is either shown the page again or successfully redirected)

#describe "user sign-in", type: :feature do
#  it "signs in in a user" do
#    user = FactoryBot.create(:user)
#   visit '/users/sign_in'
#
#    fill_in 'Email', with: user.email
#    fill_in 'Password', with: user.password
#    click_button 'Log in'
#
#    expect(page).to have_content('successfully')
#  end
#
#  it "fails user sign-in" do
#    visit '/users/sign_in'
#
#    fill_in 'Email', with: 'incorrectEmail@gmail.com'
#    fill_in 'Password', with: 'notPassword'
#    click_button 'Log in'
#
#    expect(page).to have_content('Invalid')
#  end
#
#end