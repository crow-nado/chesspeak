require 'rails_helper'

#Initial tests to confirm Capybara successfully installed
describe "initial page load", type: :feature do
  it "loads initial page" do
    visit '/'
    expect(page).to have_content('PLAY!')
  end

  it "fails test initial page" do
    visit '/'
    expect(page).to have_no_content('Bacon')
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