require 'rails_helper'

feature 'User visits profile page' do
  before :each do
    @pt = create(:progress_tracker)
    @user = User.last
    login_as(@user, scope: :user)
  end

  scenario 'successfully' do
    visit profile_path
    expect(page).to have_css 'h1', text: "Hello #{@user.username}"
  end

  scenario 'And sees his/her stats' do
    visit profile_path
    page.has_content?(@pt.exercice.name)
  end
end
