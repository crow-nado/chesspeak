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