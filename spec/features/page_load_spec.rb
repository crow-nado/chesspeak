require 'rails_helper'

#Initial test to confirm Capybara successfully installed
describe "initial page load", type: :feature do
  it "loads initial page" do
    visit '/'
    expect(page).to have_content('Hello')
  end
end