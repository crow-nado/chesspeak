require 'rails_helper'

#Initial tests to confirm Capybara successfully installed
describe "landing page", type: :feature do
  it "asks a user to sign in or sign up if they are not already signed in" do
    visit '/'
    expect(page).to have_content('SIGN IN')
  end

  it " displays the PLAY! button if a user is signed in" do
    visit '/users/sign_up'

    fill_in 'Username', with: 'test'
    fill_in 'Email', with: 'test@test.test'
    fill_in 'Password', with: 'testtest'
    fill_in 'Password confirmation', with: 'testtest'
    find('input[name="commit"]').click

    expect(page).to have_content('PLAY!')
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
    expect(page).to have_content('PLAY!')
    find('a[id="newGameButton"]').click
    expect(page).to have_content(user.username, maximum: 20)
  end
end

#Draft test for Capybara creating a new game
# describe "game setup", type: :feature do
#   it "creates a new game" do
#     user = FactoryBot.create(:user)
#     visit '/'

#     find("#submit").click

#     game = Game.last
#     expect(game.pawns.find_by(y_position: 2)).to be_instance_of(Pawn)
#     expect(game.pieces.count).to eq 32
# #   end

# end


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